class OrderSubstitutionsController < InheritedResources::Base
  skip_load_and_authorize_resource
  skip_before_filter :authenticate
    
  def create
    create! {substitutions_path}
  end


  def show
  end

  private 

  def permitted_params
    params.permit order_substitution: [:order_id, :original_sku, :substituted_confirmation_name, 
      :substituted_sku, :quantity]
  end

end
