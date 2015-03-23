class CreateMealPlans < ActiveRecord::Migration
  def change
    create_table :meal_plans do |t|
      t.string :plan_type, null: false, default: "3-day"
      t.boolean :active, null: false, default: true
      t.references :user
      t.timestamps    	
    end

    create_table :meal_plan_recipes do |t|
      t.string :meal_type, null: false, default: "lunch"
      t.date :meal_date, null: false
      t.boolean :processed, null: false, defaut: false
      t.integer :created_by
      t.integer :modified_by
      t.belongs_to :meal_plan
      t.belongs_to :recipe      
      t.timestamps
    end

  end
end
