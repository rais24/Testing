class CreateBpoProcessors < ActiveRecord::Migration
  def change
    create_table :bpo_processors do |t|
      t.datetime :last_sent
      t.string :email
      t.integer :order_id
      t.integer :last_sent_id

      t.timestamps
    end
  end
end
