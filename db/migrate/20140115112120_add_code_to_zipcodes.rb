class AddCodeToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :code, :string
  end
end
