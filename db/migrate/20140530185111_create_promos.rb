class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :code
      t.datetime :starts_on
      t.datetime :ends_on
      t.integer :quantity

      t.timestamps
    end
  end
end
