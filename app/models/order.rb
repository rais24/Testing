# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  price             :float
#  active            :boolean          default(TRUE), not null
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  price_cents       :integer          default(0), not null
#  price_currency    :string(255)      default("USD"), not null
#  delivery_site_id  :integer
#  scheduled_for     :datetime
#  delivered_at      :datetime
#  delivered         :boolean
#  checked_out       :boolean          default(FALSE), not null
#  shopping_cart_id  :integer
#  comments          :text
#  subtotal_cents    :integer          default(0), not null
#  subtotal_currency :string(255)      default("USD"), not null
#  subscription_id   :integer
#

class Order < ActiveRecord::Base
  #include Purchaseable

  delegate :name, :name_or_email, :first, :email, :family_size, to: :user, prefix: true, allow_nil: true
  delegate :cancel!, :recharge!, to: :charge, allow_nil: true

  #validates_presence_of :scheduled_for

  has_many :portions, ->{ includes(:ingredient).order('ingredients.name asc') },
           class_name: OrderPortion, dependent: :destroy do
    def add_recipe(recipe, quantity: nil)
      order  = proxy_association.owner
      #quantity ||= order.user_family_size

      recipe.portions.each do |portion|
        OrderPortion.create_from_recipe_portion(portion, quantity: quantity, to: order)
      end
    end
  end

  has_many :servings, class_name: OrderServing, dependent: :destroy

  has_many :ingredients, ->{ distinct }, through: :portions
  has_many :recipes, ->{ distinct }, through: :servings

  has_many :products, through: :order_products, dependent: :destroy
  has_many :order_products, -> { where cashback: false }, dependent: :destroy

  has_many :order_cashback_items, -> { where cashback: true }, class_name: "OrderProduct", dependent: :destroy

  has_one :charge, class_name: OrderBilling, dependent: :destroy
  has_one :delivery_time, dependent: :destroy

  has_one :address, as: :addressable, dependent: :destroy

  has_many :order_confirmations, dependent: :destroy
  has_many :order_substitutions, dependent: :destroy

  belongs_to :user
  belongs_to :shopping_cart
  belongs_to :subscription
  has_one :bpo_processor, dependent: :destroy
  
  has_one :used_promo, dependent: :destroy

  default_scope ->{ order('orders.created_at DESC') }

  scope :paid, ->{ joins(:charge) }

  scope :guest, ->{ joins(:user).where(users: { guest: true }) }
  scope :placed, ->{ joins(:user).where(users: { guest: false }) }

  scope :checked_out, ->{ where(checked_out: true) }
  scope :pending, ->{ where(checked_out: false) }

  scope :for, ->(user){ where(user_id: user.id) }
  scope :to, ->(site){ where(delivery_site_id: site.id) }

  scope :week_of, ->(date = Time.now){ where(scheduled_for: Delivery.range(date)) }

  monetize :price_cents
  monetize :subtotal_cents

  delegate :name, to: :address

  before_validation :calculate_price

  def deliverable?
    delivery_time.present?
  end

  def active?(now = Time.now)
    now < Delivery.cutoff
  end

  def can_checkout?
    servings.dinners.count >= 2
  end

  def resolve_bpo_processor
    bpo_processor ||= Orders::Router.new(self).resolve_bpo_processor
  end

  def report_name
    "#{line_item_date}_#{user_name.parameterize}"
  end

  def full_date
    scheduled_for.try :strftime, '%B %d, %Y'
  end

  def line_item_date
    scheduled_for.try :strftime, '%m-%d-%Y'
  end

  def confirm_test! customer_user
    begin
      self.comments ||= ""
      self.comments << "THIS IS A TEST ORDER. PLEASE DO NOT PROCESS!"

      bpo_instruction = generate_order_pdf
      raise StandardError.new("Failed to send PDF instructions to BPO.") unless bpo_instruction

      Mailer.bpo_instruction(self, bpo_instruction, bpo_processor.email).deliver if bpo_processor.present? && bpo_processor.email.present?

      #queue_recipe_print_job unless bpo_processor.remote_printer_email.blank?

      recipe_instructions = generate_recipe_instructions
      if recipe_instructions
        Mailer.order_confirmation_with_recipes(id, recipe_instructions).deliver
      else
        Mailer.order_confirmation(id).deliver
      end

      update! checked_out: true
    rescue StandardError => ex
      Mailer.checkout_failure(self, ex.message).deliver
      raise
    end
  end

  def confirm! customer_user
    begin
      # actually charge the card
      if charge!(customer_user.billing)
        #unless @order.bpo_processor
        raise StandardError.new("Failed to assign BPO to order.") unless resolve_bpo_processor

        bpo_instruction = generate_order_pdf
        raise StandardError.new("Failed to send PDF instructions to BPO.") unless bpo_instruction
        
        Mailer.bpo_instruction(self, bpo_instruction, bpo_processor.email).deliver 

        #queue_recipe_print_job unless bpo_processor.remote_printer_email.blank?

        recipe_instructions = generate_recipe_instructions
        if recipe_instructions
          Mailer.order_confirmation_with_recipes(id, recipe_instructions).deliver
        else
          Mailer.order_confirmation(id).deliver
        end

        update! checked_out: true
      #end
      else
        raise StandardError.new("Failed to charge credit card.")
      end
    rescue StandardError => ex
      Mailer.checkout_failure(self, ex.message).deliver
      raise
    end
  end

  def queue_recipe_print_job

      #recipe_instructions = self.generate_recipe_instructions
      #if recipe_instructions
      #  if self.bpo_processor && self.bpo_processor.remote_printer_email
      #      Mailer.recipe_instructions(self, recipe_instructions, self.bpo_processor.remote_printer_email).deliver
      #  end
      #end
      # print every thing at 11:59PM the night before scheduled delivery
      if delivery_time && delivery_time.delivery_date
        #scheduled_time = delivery_time.delivery_date.prev_day.end_of_day
        scheduled_time = 5.minutes.from_now
        OrderRecipesPrintWorker.perform_at(scheduled_time, self.id)
      end
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['ID', 'Name', 'Delivery Date']
      csv << [id, "#{user_name} - #{user_family_size}", line_item_date]

      csv << %w(Item Quantity)
      Ingredient::CATEGORIES.each do |category|
        items = portions.included.send(category)
        unless items.empty?
          csv << [category.titleize]
          items.each do |item|
            csv << [item.name, item.to_display_amount]
          end
        end
      end
    end
  end

  def total_servings
    servings.map(&:quantity).inject(:+) || 0
  end

  def price_per_serving
    Pricing.price_per_serving(total_servings.to_i)
  end

  def merge_with_cart
    self.price = self.subtotal = shopping_cart.total
    # transfer the promo to the order if its used
    shopping_cart.used_promo.update! order_id: self.id if shopping_cart.used_promo
    
    # first merge recipes
    servings.destroy_all # in case they backed out and changed their order
    recipes.destroy_all
    shopping_cart.recipe_items.each do |recipe|

      # add new recipes to the cart
      recipes << recipe.item unless recipes.find_by(id: recipe.item.id)

      # add or update servings
      serving = servings.find_by(recipe_id: recipe.item.id)
      if serving
        serving.update! quantity: recipe.quantity
      else

        servings.create(quantity: recipe.quantity, recipe_id: recipe.item.id)
      end

    end
    #portions.destroy_all
    # create order portions
    reload
    OrderPortion.transaction do
      portions.destroy_all
      servings.each do |serving|
        portions.add_recipe serving.recipe, quantity: serving.quantity
      end
    end

    order_products.destroy_all
    # need to create the store ingredients for included ingredients
    portions.reload.each do |p|
      if p.include? # included - we add empty ones
        ing = p.ingredient.products.first
        unless ing.blank?
          amt_needed = (p.quantity / ing.amount).ceil
          order_products.create(price: nil, quantity: amt_needed, product_id: ing.id)
        end
      end
    end
    save!
  end

  def serving_amount
    servings.dinners.map{|q| q.quantity}.inject(:+) || 0
  end

  def calculate_price
    self.subtotal = 0
    servings.each do |serving|
      self.subtotal += Money.new(serving.quantity.to_i * Pricing.price_per_serving(serving.quantity)) unless serving.quantity.blank?
    end
    # these are additional items not included in the price
    order_products.each do |i|
      self.subtotal += Money.new(i.total_price) unless i.price.nil?
    end
    if used_promo
      self.subtotal = subtotal - Money.new( (shopping_cart.discount_from_promo * 100).to_i )
    end
    order_cashback_items.each do |x|
      self.subtotal  -= Money.new(x.total_price/2) unless x.total_price.nil?
    end
    self.price = subtotal.cents >= 0 ? subtotal : 0.00
    price
  end
  
  def contains_pantry_items?
    return false if pantry_items.blank?
    true
  end

  def pantry_items
    return nil if order_products.empty?
    order_products.where(pantry: true).map(&:product)
  end

  def calculate_price!
    self.price = calculate_price
    save!
  end

  def ingredient_check
    ings = []
    order_products.each do |ingredient|
      ings << {quantity: ingredient.quantity, name: ingredient.confirmation_name.gsub(/\s+/,''), sku: ingredient.sku}
    end
    ings
  end

  def generate_order_pdf
    Orders::BpoInstructions.new(self)
  end

  def generate_recipe_instructions
    Orders::RecipeInstructions.new(self)
  end

  def user_name
    return address.name if (user.first.blank? || user.last.blank?)
    user.name
  end

  private

  def charge! billing
    return false unless billing.billable?
    unless charge
      # create the charge object
      charge = build_charge(billing: billing)
      charge.charge!
    end
    true
  end


end
