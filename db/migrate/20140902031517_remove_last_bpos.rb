class RemoveLastBpos < ActiveRecord::Migration
  def change
  	drop_table :last_bpos
  end
end
