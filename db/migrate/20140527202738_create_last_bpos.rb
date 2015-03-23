class CreateLastBpos < ActiveRecord::Migration
  def change
    create_table :last_bpos do |t|
      t.string :email
      t.integer :num

      t.timestamps
    end
  end
end
