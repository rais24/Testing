class AddAccountIdToBpoProcessor < ActiveRecord::Migration
  def change
    add_column :bpo_processors, :account_id, :string
  end
end
