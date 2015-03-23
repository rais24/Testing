class DietsUsersJoin < ActiveRecord::Migration
 def up
    create_table :diets_users do |t|
      t.references :diet
      t.references :user
    end
  end

  def down
    drop_table :diets_users
  end
end
