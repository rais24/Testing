class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :name, null: false, default: ""
      t.string :description, default: ""

      t.timestamps
    end
  end
end
