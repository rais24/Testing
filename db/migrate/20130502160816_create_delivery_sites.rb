class CreateDeliverySites < ActiveRecord::Migration
  def change
    create_table :delivery_sites do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :subdomain
      t.string :promo_code

      t.attachment :logo

      t.timestamps
    end
    add_index :delivery_sites, [:promo_code, :subdomain], unique: true
  end
end
