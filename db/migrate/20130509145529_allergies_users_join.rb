class AllergiesUsersJoin < ActiveRecord::Migration
  def up
    create_table :allergies_users do |t|
      t.references :allergy
      t.references :user
    end
  end

  def down
    drop_table :allergies_users
  end
end