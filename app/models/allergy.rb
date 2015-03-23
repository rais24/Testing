# == Schema Information
#
# Table name: allergies
#
#  id          :integer          not null, primary key
#  name        :string(255)      default(""), not null
#  description :string(255)      default("")
#  created_at  :datetime
#  updated_at  :datetime
#

class Allergy < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_presence_of :name
  validates_uniqueness_of :name

  delegate :titleize, to: :description
end
