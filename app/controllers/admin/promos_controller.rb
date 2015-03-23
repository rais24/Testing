module Admin
    class PromosController < BaseController
      inherit_resources

      def create
        create! {admin_promos_path}
      end
  
      def destroy
        if resource.total_used > 0
          redirect_to(admin_promos_path, {:flash => { :error => "Can't delete promo code that has been used" }})
        else
          destroy!(notice: "Promo Removed") {admin_promos_path}
        end
      end

      def update
        update!(alert: "Updated the delivery zone") {admin_promos_path}
      end

      protected
  
      def permitted_params
        params.
          permit promo: [:code, :starts_on, :ends_on, :quantity, :active,
                         :discount_cents, :discount_percent]
      end
  end
end