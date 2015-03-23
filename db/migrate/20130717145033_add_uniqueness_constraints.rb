class AddUniquenessConstraints < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true

    [:recipes, :ingredients].each do |table|
      remove_index table, :slug
      add_index table, :slug, unique: true
    end

    [:allergies, :diets].each do |table|
      add_index table, :name, unique: true
    end

    remove_index :billings, :user_id
    add_index :billings, :user_id, unique: true

    add_index :order_billings, :order_id, unique: true
  end
end
