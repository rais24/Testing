# == Schema Information
#
# Table name: billings
#
#  id                         :integer          not null, primary key
#  token                      :string(255)
#  provider                   :string(255)
#  customer_id                :string(255)
#  expiration_month           :string(255)
#  expiration_year            :string(255)
#  last_4                     :string(255)
#  user_id                    :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  name                       :string(255)
#  card_type                  :string(255)
#  subscription_id            :integer
#  encrypted_expiration_month :text
#  encrypted_expiration_year  :text
#  encrypted_last_4           :text
#  encrypted_name             :text
#  encrypted_card_type        :text
#  card_number                :string(255)
#  encrypted_card_number      :text
#  card_code                  :string(255)
#  encrypted_card_code        :text
#

class Billing < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription

  has_one :address, as: :addressable
  has_many :charges, class_name: OrderBilling

  has_many :orders, through: :charges

  validates_presence_of :user

  attr_encrypted :expiration_month, :key => ENV["EKEY"]   
  attr_encrypted :expiration_year,  :key => ENV["EKEY"]    
  attr_encrypted :card_number,      :key => ENV["EKEY"]
  attr_encrypted :card_code,        :key => ENV["EKEY"]
  attr_encrypted :last_4,           :key => ENV["EKEY"]
  attr_encrypted :name,             :key => ENV["EKEY"]
  attr_encrypted :card_type,        :key => ENV["EKEY"]

  scope :billable, ->{ where.not(customer_id: nil, token: nil) }

  # Public: deletes the Stripe::Customer associated with this billing
  #
  # billing - the Billing to use as a reference
  #
  def self.delete_customer!(billing)
    id = billing.try(:customer_id)
    Stripe::Customer.retrieve(id).delete if id
  end

  # Public: merges the given Stripe::Customer into the provided Billing
  #
  # customer - the Stripe::Customer to merge from
  #
  # billing - the Billing to merge into
  #
  # Raises ActiveRecord::RecordInvalid if the save fails
  def self.merge!(customer: nil, billing: nil)
    if card = customer.try(:active_card)
      billing.customer_id = customer.id
      billing.provider    = :stripe
      billing.name        = card.name

      billing.token     = card.fingerprint
      billing.card_type = card.type
      billing.last_4    = card.last4

      billing.expiration_month = card.exp_month
      billing.expiration_year  = card.exp_year

      billing.save!
    else
      raise StandardError.new "Customer's #active_card must not be nil"
    end
  end

  # Public: merges the given Stripe::Customer into the provided Billing
  #
  # customer - the Stripe::Customer to merge from
  #
  # billing - the Billing to merge into
  #
  def self.merge(*args)
    begin
      merge!(args)
    rescue StandardError => ex
      puts ex.inspect
    end
  end

  def disable!
    update  name: nil,
            token: nil,
            card_type: nil,
            last_4: nil,
            expiration_month: nil,
            expiration_year: nil
  end

  def billable?
    customer_id.present? && token.present?
  end

  def name
    super || user.name
  end

  def card_number_masked
    "**** **** **** #{last_4}"
  end

  def expiration_date
    return nil if expiration_month.blank? || expiration_year.blank?
    "#{expiration_month} / #{expiration_year}"
  end
end
