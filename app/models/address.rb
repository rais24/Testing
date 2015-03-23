# == Schema Information
#
# Table name: addresses
#
#  id                   :integer          not null, primary key
#  street1              :string(255)
#  street2              :string(255)
#  city                 :string(255)
#  state                :string(255)
#  zipcode              :string(255)
#  phone                :string(255)
#  addressable_id       :integer
#  addressable_type     :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  first_name           :string(255)
#  last_name            :string(255)
#  encrypted_first_name :text
#  encrypted_last_name  :text
#  encrypted_street1    :text
#  encrypted_street2    :text
#  encrypted_city       :text
#  encrypted_state      :text
#  encrypted_zipcode    :text
#  encrypted_phone      :text
#

class Address < ActiveRecord::Base
  include Zippable

  validates_presence_of :street1, :city, :state, :first_name, :last_name
  
  belongs_to :addressable, polymorphic: true

  attr_encrypted :street1,    :key => ENV["EKEY"]   
  attr_encrypted :street2,    :key => ENV["EKEY"]    
  attr_encrypted :city,       :key => ENV["EKEY"]
  attr_encrypted :state,      :key => ENV["EKEY"]
  attr_encrypted :zipcode,    :key => ENV["EKEY"]
  attr_encrypted :first_name, :key => ENV["EKEY"]
  attr_encrypted :last_name,  :key => ENV["EKEY"]
   
  def street
    line = ""
    line << street1
    line << ", #{street2}"
    line
  end

  def name
    [first_name, last_name].join(" ")
  end

  def city_line
    "#{city}, #{state} #{zipcode}"
  end
end
