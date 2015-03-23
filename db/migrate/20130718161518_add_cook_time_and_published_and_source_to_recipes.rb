class AddCookTimeAndPublishedAndSourceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :cook_time, :integer, default: 0, null: false
    add_column :recipes, :published, :boolean, default: false, null: false
    add_column :recipes, :source, :string, default: '', null: false

    Recipe.update_all(published: true)
  end
end
