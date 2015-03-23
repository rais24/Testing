class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name,         null: false, default: 0
      t.text :preparation
      t.text :description
      t.integer :prep_time,   null: false, default: 0
      t.float :price,         null: false, default: 0

      t.attachment :photo

      t.timestamps
    end
  end
end
