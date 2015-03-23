# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  category   :string(255)
#  prompt     :text
#  symbol     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  #TODO: Delete this class and table from schema
  after_create :set_symbol

  scope :dietary_needs, ->{ where(category: "dietary_needs") }
  scope :dietary_preferences, ->{ where(category: "dietary_preferences") }
  scope :dietary_dislikes, ->{ where(category: "dietary_dislikes") }

  # This will result in a symbol that is unique to each question
  # The question's symbol is used in retrieving the answers from the questions
  # inside a controller that doesn't know the items in the params hash
  def set_symbol
    self.symbol = "q_" + self.id.to_s
    self.save
  end
end
