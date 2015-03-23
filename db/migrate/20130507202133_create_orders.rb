class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.float :price

      t.boolean :active, null: false, default: true

      t.references :user
      t.references :delivery

      t.timestamps
    end
  end
end
