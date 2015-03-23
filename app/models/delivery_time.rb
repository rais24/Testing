# == Schema Information
#
# Table name: delivery_times
#
#  id               :integer          not null, primary key
#  delivery_date    :date
#  time_slot        :string(255)
#  order_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#  delivery_zone_id :integer
#

class DeliveryTime < ActiveRecord::Base
  INTERVAL = 2
  MAX_DELIVERIES = 4

  validates :delivery_date, presence: true
  validates :time_slot, presence: true
  validate  :time_slot_must_be_valid_interval
  validate  :must_be_less_than_max_deliveries
  validates_presence_of :delivery_zone
  validates_presence_of :order

  belongs_to :order
  belongs_to :delivery_zone

  def date_and_time
    "#{delivery_date.strftime('%A, %B')} #{delivery_date.day.ordinalize} between #{time_slot_verbose}"
  end

  def time_slot_verbose 
    time_slot.gsub(/-/," and ").gsub(/am/, " AM").gsub(/pm/, " PM")
  end

  private

  def time_slot_must_be_valid_interval
   	start_hour, end_hour = time_slot.to_s.split("-")
   	if end_hour.to_i == 12
  		errors.add(:time_slot, 'must be a 2-hour interval') unless start_hour.to_i == (end_hour.to_i - DeliveryTime::INTERVAL)
   	else
  		errors.add(:time_slot, 'must be a 2-hour interval') unless end_hour.to_i == ((start_hour.to_i + DeliveryTime::INTERVAL) % 12)
   	end
  end

  def must_be_less_than_max_deliveries
    unless order.user.user_group && order.user.user_group.delivery_times
      total_deliveries_scheduled = DeliveryTime.where({delivery_date: delivery_date, time_slot: time_slot, delivery_zone_id: delivery_zone.id}).count
      errors.add(:Sorry,  "we're all booked up for that time. Please select another time to receive your delivery") if DeliveryTime::MAX_DELIVERIES <= total_deliveries_scheduled
    end
  end

end
