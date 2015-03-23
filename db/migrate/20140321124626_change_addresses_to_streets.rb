class ChangeAddressesToStreets < ActiveRecord::Migration
  def change
    rename_column :addresses, :address1, :street1
    rename_column :addresses, :address2, :street2
  end
end
