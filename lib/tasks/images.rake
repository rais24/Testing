namespace :images do
  desc "Synchornize images on production into localhost"
  task :to_localhost => [:environment] do
    unless Rails.env == "production"
      s3 = AWS::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
      bucket = s3.buckets['fitly-staging']

      Recipe.all.each do |recipe|
        # path = "http://s3.amazonaws.com/fitly-staging/recipes/photos/000/000/0#{recipe.id}/original/#{recipe.photo_file_name}"
        # puts "getting photo from #{path}"
        # puts recipe.photo.url
        begin
          id = "%03d" % recipe.id
          s3obj = "recipes/photos/000/000/#{id}/original/#{recipe.photo_file_name}"
          obj = bucket.objects[s3obj]
          puts "accessing file #{s3obj}"
          File.open("tmp/#{recipe.photo_file_name}", "wb") {|f| f.write(obj.read)}
          recipe.photo = File.open("tmp/#{recipe.photo_file_name}")
          recipe.save!
        rescue => e
          puts e.message
          puts "Error with #{recipe.photo.url}"
        end
      end
    end
  end
end
