class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
    	t.string   :name, null: false
    	t.integer  :user_count, null: false, default: 0
    	t.string   :code, null: false
    	t.integer  :delivery_zone_id
    	t.text     :welcome_greeting, null: false
    	t.text     :delivery_instructions, null: false
    	t.string   :delivery_times

	  	t.timestamps    	
    end
  end
end
