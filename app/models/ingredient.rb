# == Schema Information
#
# Table name: ingredients
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  unit               :string(255)      not null
#  category           :string(255)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  price_cents        :integer          default(0), not null
#  price_currency     :string(255)      default("USD"), not null
#  pantry             :boolean          default(FALSE), not null
#  slug               :string(255)
#  measurement_type   :string(255)
#  cash_back          :boolean          default(FALSE), not null
#

class Ingredient < ActiveRecord::Base
  #include Slugged
  
  UNITS      = %w(oz tsp unit)
  CATEGORIES = %w(meats produce groceries)
  MEASURE_TYPES = %w(liquid solid)

  validates_presence_of :name, :unit, :category

  has_many :recipe_portions, dependent: :destroy
  has_many :recipes, through: :recipe_portions
  has_many :order_portions, dependent: :destroy
  has_many :products

  # validates_inclusion_of :unit, in: UNITS
  validates_inclusion_of :category, in: CATEGORIES
  #validates_inclusion_of :state, in: %W(solid liquid)

  monetize :price_cents

  has_attached_file :photo, default_url: "/assets/defaults/ingredient.jpg",
                     styles: { medium: "300x300>", thumb: "100x100#" }

  validates_attachment_content_type :photo, :content_type => /\Aimage/
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/]

  #validates_uniqueness_of :name

  default_scope { order('ingredients.name asc') }

  CATEGORIES.each do |category_scope|
    scope category_scope, ->{ where(category: category_scope) }
  end

  scope :cash_back, -> { where(cash_back: true) }
  scope :pantry, -> { where(pantry: true) }
  scope :not_pantry, -> { where(pantry: false) }

  scope :no_product, -> { includes(:products).select{ |x| x.products.empty? } }
  scope :with_product, -> { includes(:products).reject{ |x| x.products.empty? } }

end
