class AddDeliveryFieldsToOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :delivery_id
    add_column :orders, :delivery_site_id, :integer
    add_column :orders, :scheduled_for, :datetime
    add_column :orders, :delivered_at, :datetime
    add_column :orders, :delivered, :boolean

    add_index :orders, :delivery_site_id
    add_index :orders, :scheduled_for
    add_index :orders, :delivered

    Order.find_each do |order|
      user = order.user
      if user && site = user.site
        order.update! delivery_site_id: site.id
      end
    end
  end
end
