class ProductsController < InheritedResources::Base
  #include SluggedResource

  def create
    #arams[:product][:ingredient] = Ingredient.find(params[:product][:ingredient]) if params[:product][:ingredient].present?
    create! {products_path}
  end

  def update
    if params[:product][:stores]    
      new_stores = Store.find(params[:product][:stores].reject{|x| x.blank?}) 
      new_stores.each { |x| @product.stores << x unless @product.stores.include?(x) }
    end
    @product.update permitted_params[:product]
    redirect_to products_path
  end
  
  def destroy
    destroy! {products_path}
  end

  def permitted_params
    params.permit product: [:friendly_name, :brand_and_item, :ingredient_id, 
      :sku, :sku_quantity, :amount, :unit, :price, :confirmation_name]
  end

end
