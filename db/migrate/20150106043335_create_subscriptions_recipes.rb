class CreateSubscriptionsRecipes < ActiveRecord::Migration
  def change
    create_table :subscriptions_recipes, id: false do |t|
      t.belongs_to :subscription
      t.belongs_to :recipe
    end
  end
end
