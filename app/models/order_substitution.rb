# == Schema Information
#
# Table name: order_substitutions
#
#  id                            :integer          not null, primary key
#  order_id                      :integer          not null
#  original_sku                  :string(255)      not null
#  substituted_confirmation_name :string(255)      not null
#  substituted_sku               :string(255)      not null
#  quantity                      :string(255)      not null
#  created_at                    :datetime
#  updated_at                    :datetime
#

class OrderSubstitution < ActiveRecord::Base
  belongs_to :order

  before_create :normalize_confirmation_name
  before_save :normalize_confirmation_name

  validates_presence_of :order_id, :original_sku, :substituted_sku, :quantity, :substituted_confirmation_name

  private 

  def normalize_confirmation_name
  	self.substituted_confirmation_name = self.substituted_confirmation_name.gsub(/\s/, '').gsub(/\p{Z}/,'')
  end

end
