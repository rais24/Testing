# == Schema Information
#
# Table name: recipe_portions
#
#  id                      :integer          not null, primary key
#  quantity                :float            default(0.0), not null
#  ingredient_id           :integer
#  recipe_id               :integer
#  created_at              :datetime
#  updated_at              :datetime
#  include                 :boolean          default(TRUE), not null
#  order                   :integer
#  additional_instructions :string(255)
#

class RecipePortion < ActiveRecord::Base
  include Measureable
  include Portionable

  belongs_to :recipe
  validates_presence_of :recipe
  validates_uniqueness_of :order, :scope => :recipe_id

  belongs_to :ingredient
  validates_presence_of :ingredient

  scope :included, ->{ where(include: true) }
  scope :excluded, ->{ where(include: false) }

  scope :published, ->{ joins(:recipe).merge(Recipe.published) }
  scope :unpublished, ->{ joins(:recipe).merge(Recipe.unpublished) }

  # right now this is for admin checks only
  def show_store_quantity(_quantity=4)
    quantity * _quantity
  end
end
