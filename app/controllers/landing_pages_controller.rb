class LandingPagesController < InheritedResources::Base
  skip_load_and_authorize_resource

  #layout "layouts/lander"
  
  def index 
  end
  
  def create    
    respond_to do |format|
      if Zipcode.find_by_code(params[:zipcode]).nil?
        list_id = "d24161bd61"
        format.js { render json: {txt: 'Not Found', zip: params[:zipcode]} }
      else
        list_id = "9ac37244da"
        format.js { render json: {txt: 'Found', zip: params[:zipcode]} }
      end
    end
  end
  
  def show
    # for now we dont care what landing id is shown
    @lander = params[:id]
    unless @lander.blank?
      render @lander.to_sym 
    end
  end
      
  def beta_signup
  end
end
