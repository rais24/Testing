class DropUniqueIndexOnIngredientsSlug < ActiveRecord::Migration
  def change
    remove_index "ingredients", ["slug"]
  end
end
