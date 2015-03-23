module Users
  class Registrar < Struct.new(:from_user, :to_user, :order_worker)
    delegate :site, :orders, to: :to_user

    def register
      move_orders
      if orders.last
        to_user.update! locked: orders.last.servings.empty?
      end
      to_user
    end

    private
      # Public: this is meant to migrate a Guest User's relations to another user,
      #         typically one who has finished the registration process
      #
      # :user - The recipient
      #
      # Returns the recipient
      def move_orders
        order = from_user.orders.last
        if to_user && to_user.site
          order.update! user_id: to_user.id
          order_worker.perform(order.id)
        end
      end
  end
end