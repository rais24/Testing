class StoresController < InheritedResources::Base
  #include SluggedResource

  def create
    #arams[:product][:ingredient] = Ingredient.find(params[:product][:ingredient]) if params[:product][:ingredient].present?
    create! {stores_path}
  end

  def update
    #params[:product][:ingredient] = Ingredient.find(params[:product][:ingredient]) if params[:product][:ingredient].present?
    update! {stores_path}
  end
  
  def destroy
    destroy! {stores_path}
  end

  def permitted_params
    params.permit store: [:name, :code, :password, :store_password, :store_email, :store_website, :remote_printer_email]
  end

end
