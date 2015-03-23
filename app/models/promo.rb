# == Schema Information
#
# Table name: promos
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  starts_on         :date
#  ends_on           :date
#  quantity          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  active            :boolean          default(TRUE)
#  discount_cents    :integer          default(0), not null
#  discount_currency :string(255)      default("USD"), not null
#  discount_percent  :integer
#  max_utilization   :integer          default(1), not null
#  min_order_price   :float
#  max_order_price   :float
#  auto_apply        :boolean          default(FALSE), not null
#

class Promo < ActiveRecord::Base
  validates_uniqueness_of :code
  validates_presence_of :starts_on, :ends_on, :quantity
  monetize :discount_cents
  
  has_many :used_promos
  
  def total_used
    used_promos.used.count
  end
  
  def amount_off(subtotal)
    begin
      return (Float(discount_percent / 100.0) * subtotal) if discount_percent.present? && discount_percent > 0
      return discount if discount_cents.present? && discount_cents > 0      
    rescue
      return Money.new(0)
    end
  end

end
