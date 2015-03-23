class ChangePromoStartAndEndToDatetime < ActiveRecord::Migration
  def change
    change_column :promos, :starts_on, :date
    change_column :promos, :ends_on, :date
  end
end
