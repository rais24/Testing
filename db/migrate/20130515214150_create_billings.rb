class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.string :token
      t.string :provider
      t.string :customer_id
      t.string :image_url
      t.string :expiration_month
      t.string :expiration_year
      t.string :last_4
      
      t.references :user

      t.timestamps
    end
    add_index :billings, :user_id
  end
end
