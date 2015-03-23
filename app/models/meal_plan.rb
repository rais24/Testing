# == Schema Information
#
# Table name: meal_plans
#
#  id         :integer          not null, primary key
#  plan_type  :string(255)      default("3-day"), not null
#  active     :boolean          default(TRUE), not null
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class MealPlan < ActiveRecord::Base

  SUPPORTED_PLANS = [3, 5, 10, 21]

  has_many :meal_plan_recipes
  belongs_to :user

end
