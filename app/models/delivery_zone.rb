# == Schema Information
#
# Table name: delivery_zones
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  days             :string(255)
#  user_group_id    :integer
#  restricted_times :string(255)
#

class DeliveryZone < ActiveRecord::Base
  validates :name, presence: true
  has_many :zipcodes
  has_many :delivery_times
  belongs_to :user_group
  
  scope :general, -> { where(user_group_id: nil) }

  def valid_times
    ["7am-9am", "9am-11am","11am-1pm","3pm-5pm","5pm-7pm","7pm-9pm"]
  end

  def valid_days
    if name == "1"
      ["Tuesday", "Thursday", "Sunday"]
    elsif name == "2"
      ["Tuesday", "Thursday", "Sunday"]
    elsif name == "3"
      ["Monday", "Wednesday", "Friday"]
    elsif name == "4"
      ["Wednesday", "Saturday"]
    elsif name == "5"
      ["Monday", "Friday", "Saturday"]
    end
  end
end
