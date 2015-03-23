class DeliveryChoices < ActiveRecord::Migration
  def up
    create_table :delivery_choices do |t|
      t.references :recipe
      t.references :delivery

      t.timestamps
    end
  end

  def down
    drop_table :delivery_choices
  end
end
