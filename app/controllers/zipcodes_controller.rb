class ZipcodesController < InheritedResources::Base
   skip_load_and_authorize_resource
   

   def permitted_params
     params.permit zipcode: [:name]
   end
end
