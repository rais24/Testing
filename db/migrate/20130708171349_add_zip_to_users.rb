class AddZipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string, default: "", null: false
    
    # Set a pre-existing User's :zipcode to their Site's
    User.where(zipcode: "").each do |user|
      site_zip = user.site.try(:zip)
      if site_zip.present?
        user.update! zipcode: site_zip
      end
    end
  end
end
