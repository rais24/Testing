module Admin
  class ReportsController < BaseController    

    def order_details
      @orders = Order.includes(:servings, :recipes, :bpo_processor, :address, :used_promo => :promo, :user => :address, :delivery_time => :delivery_zone).all
    end

    def monthly_report
      all_users_by_month = User.includes(:orders).load.reject{ |x| x.email.blank? }.group_by{ |t| t.created_at.beginning_of_month }
      all_orders_by_month = Order.includes(used_promo: :promo).checked_out.group_by{ |t| t.created_at.beginning_of_month }
      @monthly_statistics = {}
      @total_registrants = 0
      @total_customers = 0
      @total_repeat_customers = 0
      all_users_by_month.sort_by{|x,y| x}.each do |x,y|
        current_month_total_users = y.size
        @total_registrants += current_month_total_users
        current_month_customers = y.reject{ |x| x.orders.where(checked_out: true).blank? }.size
        @total_customers += current_month_customers
        current_month_repeat_customers = y.reject{ |x| x.orders.where(checked_out: true).count < 2 }.size
        @total_repeat_customers += current_month_repeat_customers
        prev_month_total_users = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:registrations] : 0
        prev_month_total_customers = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:registrations] : 0
        prev_month_total_repeat_customers = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:repeat_customers] : 0
        registrations_growth = (prev_month_total_users.nil? || prev_month_total_users.zero?) ? nil : ((current_month_total_users-prev_month_total_users)/prev_month_total_users*100.0)
        customers_growth = (prev_month_total_customers.nil? || prev_month_total_customers.zero?) ? nil : ((current_month_customers-prev_month_total_customers)/prev_month_total_customers*100.0)
        repeat_customers_growth = (prev_month_total_repeat_customers.nil? || prev_month_total_repeat_customers.zero?) ? nil : ((current_month_repeat_customers-prev_month_total_repeat_customers)/prev_month_total_repeat_customers*100.0)
        @monthly_statistics[x] = {
          registrations: current_month_total_users, 
          registrations_growth: registrations_growth,
          customers: current_month_customers,
          customers_growth: customers_growth,
          repeat_customers: current_month_repeat_customers,
          repeat_customers_growth: repeat_customers_growth
        }
      end
      @total_orders = 0
      @total_revenue = 0.0
      @total_promos = 0.0
      @total_revenue_after_promos = 0.0
      all_orders_by_month.sort_by{|x,y| x}.each do |x,y|
        current_month_orders = y.count
        @total_orders += current_month_orders
        current_month_total = y.sum(&:price).to_f
        @total_revenue_after_promos += current_month_total
        current_month_promos = y.sum{ |p| p && p.used_promo ? p.used_promo.discount.to_f : 0 }
        @total_promos += current_month_promos
        current_month_subtotal = current_month_promos + current_month_total
        @total_revenue += current_month_subtotal
        prev_month_total = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:total] : 0.0
        prev_month_subtotal = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:subtotal] : 0.0
        prev_month_promos = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:promos] : 0.0
        prev_month_orders = @monthly_statistics[x.months_ago(1)] ? @monthly_statistics[x.months_ago(1)][:orders] : 0
        total_growth = (prev_month_total.nil? || prev_month_total.zero?) ? nil : ((current_month_total-prev_month_total)/prev_month_total*100.0)
        subtotal_growth = (prev_month_subtotal.nil? || prev_month_subtotal.zero?) ? nil : ((current_month_subtotal-prev_month_subtotal)/prev_month_subtotal*100.0)
        promos_growth = (prev_month_promos.nil? || prev_month_promos.zero?) ? nil : ((current_month_promos-prev_month_promos)/prev_month_promos*100.0)
        orders_growth = (prev_month_orders.nil? || prev_month_orders.zero?) ? nil : ((current_month_orders-prev_month_orders)/prev_month_orders*100.0)
        @monthly_statistics[x][:total] = current_month_total
        @monthly_statistics[x][:total_growth] = total_growth
        @monthly_statistics[x][:subtotal] = current_month_subtotal
        @monthly_statistics[x][:subtotal_growth] = subtotal_growth
        @monthly_statistics[x][:promos] = current_month_promos
        @monthly_statistics[x][:promos_growth] = promos_growth
        @monthly_statistics[x][:orders] = current_month_orders
        @monthly_statistics[x][:orders_growth] = orders_growth
      end
    end

  end
end
