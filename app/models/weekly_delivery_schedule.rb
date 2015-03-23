# == Schema Information
#
# Table name: weekly_delivery_schedules
#
#  id                    :integer          not null, primary key
#  delivery_day          :string(255)
#  time_slot             :string(255)
#  delivery_instructions :string(255)
#  subscription_id       :integer
#  user_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class WeeklyDeliverySchedule < ActiveRecord::Base

  belongs_to :subscription
  belongs_to :user

end
