class AddNameAndTypeToBilling < ActiveRecord::Migration
  def change
    add_column :billings, :name, :string
    add_column :billings, :card_type, :string

    remove_column :billings, :image_url
  end
end
