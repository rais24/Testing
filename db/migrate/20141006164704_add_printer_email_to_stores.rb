class AddPrinterEmailToStores < ActiveRecord::Migration
  def change
 	Store.reset_column_information
    add_column(:stores, :remote_printer_email, :string) unless Store.column_names.include?('remote_printer_email')
  end
end
