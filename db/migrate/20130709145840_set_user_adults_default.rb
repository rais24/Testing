class SetUserAdultsDefault < ActiveRecord::Migration
  def change
    change_column :users, :adults, :integer, default: 1, null: false

    User.where(adults: 0).each do |u|
      u.update! adults: 1
    end
  end
end
