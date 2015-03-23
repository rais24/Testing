class CreateStoreZipcodes < ActiveRecord::Migration
  def change
    create_table :store_zipcodes, id: false do |t|
      t.belongs_to :store
      t.belongs_to :zipcode
      t.integer	   :load_percent, null: false, default: 100
      t.text	   :bpo_processors, null: true
    end
  end
end
