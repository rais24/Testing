# == Schema Information
#
# Table name: stores
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  code                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  password             :string(255)
#  store_password       :string(255)
#  store_email          :string(255)
#  store_website        :string(255)
#  remote_printer_email :string(255)
#

class Store < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :ingredients

  has_many :bpo_processors
  
  has_many :zipcodes, through: :store_zipcodes, dependent: :destroy
  has_many :store_zipcodes, dependent: :destroy

  has_many :delivery_zone, through: :zipcodes

  validates_presence_of :name

end
