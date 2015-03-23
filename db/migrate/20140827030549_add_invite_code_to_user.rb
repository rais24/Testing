class AddInviteCodeToUser < ActiveRecord::Migration
  def change
  	User.reset_column_information
    add_column(:users, :user_group_id, :integer, null: true) unless User.column_names.include?('user_group_id')
    add_column(:users, :invite_code, :string, null: true) unless User.column_names.include?('invite_code')
  end
end
