class AddStoreToBpoProcessor < ActiveRecord::Migration
  def change
 	BpoProcessor.reset_column_information
    add_column(:bpo_processors, :store_id, :integer) unless BpoProcessor.column_names.include?('store_id')
  end
end
