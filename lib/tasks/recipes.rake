namespace :recipes do
  desc "Update recipe portions for inclusion"
  task update_recipe_portions: :environment do
    Recipe.find_each do |recipe|
      puts "Updating #{recipe.name}"
      recipe.portions.each do |portion|
        begin
          portion.update! include: !portion.pantry?
        rescue
          puts "couldn't update #{portion.name} from #{recipe.name}"
        end
      end
    end
  end

  desc "Identify diet types and preferences for recipes"
  task :assign_categories_to_recipes, [:category] => :environment do |t, args|
    args.with_defaults(:category => "diabetes-friendly")
    Recipe.all.each do |recipe|
      recipe.assign_medical_nutrition_category args.category.gsub(/-/,' ')
      begin
        recipe.save!
      rescue
        puts "Failed to update recipe #{recipe.slug}"
        next
      end
    end
  end

  desc "Populate nil descriptions"
  task populate_descriptions: :environment do
    Recipe.where(description: nil).find_each do |recipe|
      recipe.update! description: ""
    end
  end

  namespace :dev do
    desc "Clear all recipes, ingredients, and portions"
    task clear: :environment do
      Recipe.destroy_all
      Ingredient.destroy_all
    end

    namespace :paperclip do
      desc "Clear thumbnail data"
      task clear: :environment do
        Recipe.find_each do |recipe|
          recipe.update!  photo_file_name: nil,
                          photo_content_type: nil,
                          photo_file_size: nil
        end
      end
    end
  end
end
