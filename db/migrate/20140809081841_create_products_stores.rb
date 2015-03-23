class CreateProductsStores < ActiveRecord::Migration
  def change
    create_table :products_stores, id: false do |t|
      t.belongs_to :product
      t.belongs_to :store
    end
  end
end
