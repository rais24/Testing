module Orders
  class Scheduler < Struct.new(:orders, :site)
    def schedule!(date = Time.now, &block)
      if week_of(date)
        raise ConflictError.new("A Delivery is already scheduled for #{date}")
      else
        created = orders.create! scheduled_for: Delivery.next(date), site: site
        if block
          yield created 
        end
        created
      end
    end

    def week_of(date = Time.now)
      search = orders.week_of(date)
      if site
        search = search.to(site)
      end
      search.first
    end
  end
end