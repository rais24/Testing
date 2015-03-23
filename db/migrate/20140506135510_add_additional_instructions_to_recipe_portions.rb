class AddAdditionalInstructionsToRecipePortions < ActiveRecord::Migration
  def change
    add_column :recipe_portions, :additional_instructions, :string
  end
end
