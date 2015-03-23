class AddNumberToLastBpo < ActiveRecord::Migration
  def change
    add_column :last_bpos, :last_bpo_id, :integer
  end
end
