module Admin
    class ZipcodesController < BaseController
      inherit_resources
      load_resource :zipcode, :except => [:create]

      def index
        @zipcodes = Zipcode.includes(:delivery_zone).order(:code)
      end

      def edit
      end

      def create
        @zipcode = Zipcode.new
        @zipcode.name = permitted_params[:zipcode][:name]
        @zipcode.code = permitted_params[:zipcode][:code]
        @zipcode.delivery_zone = DeliveryZone.find(permitted_params[:zipcode][:delivery_zone])
        if @zipcode.save
          redirect_to admin_zipcodes_path, alert: "Created the zip code"
        else
          redirect_to admin_zipcodes_path
        end
      end

      def update
        @zipcode.name = permitted_params[:zipcode][:name]
        @zipcode.code = permitted_params[:zipcode][:code]
        @zipcode.delivery_zone_id = permitted_params[:zipcode][:delivery_zone]
        if @zipcode.save
          redirect_to admin_zipcodes_path, alert: "Updated the zip code"
        else
          redirect_to admin_zipcodes_path
        end
      end
  
      def destroy
        destroy!(notice: "Zip Code Removed") {admin_zipcode_path}
      end
  
      protected
  
      def permitted_params
        params.
          permit zipcode: [:name, :code, :delivery_zone]
      end
  end
end