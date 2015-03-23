class AddPublishDateToRecipes < ActiveRecord::Migration
  class Recipe < ActiveRecord::Base
	  scope :published, ->{ where(published: true) }
  end

  def change
    add_column :recipes, :published_at, :datetime
    Recipe.published.each_with_index do |recipe, n|
    	# Stagger publish dates initially 10 minutes apart
    	recipe.update_attribute(:published_at, DateTime.parse("07/06/2014") + (n*10).minutes )
    end
  end
end
