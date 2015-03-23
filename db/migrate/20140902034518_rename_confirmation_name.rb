class RenameConfirmationName < ActiveRecord::Migration
  def change
	rename_column :products, :shoprite_confirmation_name, :confirmation_name
  end
end
