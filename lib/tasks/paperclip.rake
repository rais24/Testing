namespace :paperclip do
  namespace :reload do
    desc "Reload Recipes"
    task recipes: :environment do
      Recipe.find_each do |recipe|
        PaperclipDownloader.new(:photo, recipe).swap
      end
    end
  end
  
  desc "Reprocess images"
  task reprocess: :environment do
    Recipe.find_each do |recipe|
      begin
        recipe.photo.reprocess!
      rescue => e
        puts e.message
      end
    end
  end
end