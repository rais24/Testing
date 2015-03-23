# == Schema Information
#
# Table name: store_zipcodes
#
#  store_id       :integer
#  zipcode_id     :integer
#  load_percent   :integer          default(100), not null
#  bpo_processors :text
#

class StoreZipcode < ActiveRecord::Base
  belongs_to :store
  belongs_to :zipcode

  validates_presence_of :load_percent, :store, :store

end
