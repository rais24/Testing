# == Schema Information
#
# Table name: meal_plan_recipes
#
#  id           :integer          not null, primary key
#  meal_type    :string(255)      default("lunch"), not null
#  meal_date    :date             not null
#  processed    :boolean          not null
#  created_by   :integer
#  modified_by  :integer
#  meal_plan_id :integer
#  recipe_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class MealPlanRecipe < ActiveRecord::Base

  belongs_to :meal_plan
  belongs_to :recipe
  belongs_to :created_by,  :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by'


end
