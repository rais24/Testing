class AddEligibleToUser < ActiveRecord::Migration
  def change
    add_column :users, :eligible, :boolean, default: false, null: false
  end
end
