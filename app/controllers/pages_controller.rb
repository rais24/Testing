class PagesController < HighVoltage::PagesController
  skip_load_and_authorize_resource
  skip_before_filter :authenticate

  def show
    case params[:id]
    when "pricing", "signed_up", "signed_up_noplan", "preferences_complete"
	  	respond_to do |format|
	      format.html {render params[:id].to_sym, :layout => false}
	    end
		else
  		respond_to do |format|
      	format.html {render params[:id].to_sym, :layout => 'application'}
    	end
		end
  end

end