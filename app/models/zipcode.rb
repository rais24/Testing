# == Schema Information
#
# Table name: zipcodes
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  code             :string(255)
#  delivery_zone_id :integer
#

class Zipcode < ActiveRecord::Base
  #validates :name, presence: true
  belongs_to :delivery_zone
  validates :code, presence: true
  validates_uniqueness_of :code

  has_many :stores, through: :store_zipcodes, dependent: :destroy
  has_many :store_zipcodes, dependent: :destroy

  def display_name
  	"#{name} (#{code})"
  end

	def self.can_service_zipcode? zipcode
    unless zipcode && !zipcode.blank?
      return "Zipcode not provided"
    end
    unless Zipcode.exists?(code: zipcode)
      return "Zipcode #{zipcode} not currently serviced"
    end
    return ""
 	end

end
