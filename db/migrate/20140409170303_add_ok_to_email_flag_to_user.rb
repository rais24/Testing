class AddOkToEmailFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :ok_to_email, :boolean, default: false
  end
end
