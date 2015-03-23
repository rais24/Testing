module Admin
    class DeliveryZonesController < BaseController
      inherit_resources
      load_resource :delivery_zone

      def index
        @delivery_zones = DeliveryZone.general.includes(:zipcodes)
      end

      def edit
      end

      def update
        valid_zipcodes = params[:delivery_zone][:zipcodes].reject{ |x| x.blank? }
        @delivery_zone.days = params[:delivery_zone][:days]
        @delivery_zone.zipcodes << Zipcode.find(valid_zipcodes) unless valid_zipcodes.blank?
        if @delivery_zone.save
          redirect_to admin_delivery_zones_path, alert: "Updated the delivery zone"
        else
          redirect_to admin_delivery_zones_path
        end
      end
  
      def destroy
        destroy!(notice: "Delivery Zone Removed") {admin_delivery_zones_path}
      end
  
      protected
  
      def permitted_params
        params.
          permit delivery_zone: [:zipcodes, :days]
      end
  end
end