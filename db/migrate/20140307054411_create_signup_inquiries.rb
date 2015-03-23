class CreateSignupInquiries < ActiveRecord::Migration
  def change
    create_table :signup_inquiries do |t|
      t.string :zipcode, 		null: false, default: ""
      t.string :email,      	null: false, default: ""
   	  t.string :invite_code,    null: false, default: ""

      t.timestamps
    end
  end
end
