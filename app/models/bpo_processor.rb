# == Schema Information
#
# Table name: bpo_processors
#
#  id           :integer          not null, primary key
#  last_sent    :datetime
#  email        :string(255)
#  order_id     :integer
#  last_sent_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  account_id   :string(255)
#  store_id     :integer
#

class BpoProcessor < ActiveRecord::Base
  belongs_to :order
  belongs_to :store

  MAX = 3
  # using .org for now since its already set up
  DOMAIN = "@fitly.com"
  ACCOUNTS = %w(451519007729 451519007736 451519007743 451519007750 451519007767)

  delegate :name, :store_website, :remote_printer_email, to: :store

  before_create :get_email
  
  def store_email
    return nil if store.blank? || store.store_email.blank?
    store.store_email.gsub(/{last_sent_id}/, last_sent_id.to_s)
  end

  def store_password
    return nil if store.blank? || store.store_password.blank?
    store.store_password.gsub(/{last_sent_id}/, last_sent_id.to_s)
  end

  def password
    return nil if store.blank? || store.password.blank?
    store.password.gsub(/{last_sent_id}/, last_sent_id.to_s)
  end

  def store_zipcode
    return nil if store.zipcodes.empty?
    store.zipcodes.first.code
  end

  def get_email
    next_id = resolve_next_id
    self.last_sent_id = next_id
    self.account_id = ACCOUNTS[next_id-1]
    self.email = "bpo#{next_id}#{DOMAIN}"
  end

  private 

  def resolve_next_id
    last_sent = BpoProcessor.last
    return 1 if last_sent.blank? || last_sent.last_sent_id.to_i == MAX
    ret_val = last_sent.last_sent_id.to_i + 1
  end
      
end
