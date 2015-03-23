class AddStoreCredentialsToStores < ActiveRecord::Migration
  def change
 	Store.reset_column_information
    add_column(:stores, :password, :string) unless Store.column_names.include?('password')
    add_column(:stores, :store_password, :string) unless Store.column_names.include?('store_password')
    add_column(:stores, :store_email, :string) unless Store.column_names.include?('store_email')
    add_column(:stores, :store_website, :string) unless Store.column_names.include?('store_website')
  end
end
