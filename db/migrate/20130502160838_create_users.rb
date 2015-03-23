class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,          null: false, default: ""
      t.string :password_digest,null: false, default: ""
      t.string :first
      t.string :last
      t.integer :adults,        null: false, default: 0
      t.integer :children,      null: false, default: 0

      t.string :password_reset_token, null: false, default: ""
      t.datetime :password_reset_sent_at

      t.string :role,           null: false, default: ""
      t.boolean :active,        null: false, default: false

      # for registration locking
      t.string :auth_token,     null: false, default: ""
      t.boolean :locked,        null: false, default: true

      t.references :delivery_site
      t.references :billing

      t.timestamps
    end
  end
end
