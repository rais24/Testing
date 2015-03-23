class SessionsController < ApplicationController
  skip_load_and_authorize_resource
  skip_before_filter :authenticate

  def new
    render :layout => false
  end

  def create
    if params[:email].empty? || params[:password].empty?
      flash.now[:error] = "We don't recognize those credentials"
      redirect_to login_path and return
    end
    if user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      login(user)

      if flash[:denied_request].present?
        redirect_to flash[:denied_request]
      else
        if user.is_specialist?
          redirect_to show_patients_account_path 
        elsif user.subscription.present?  
          redirect_to account_path
        else
          if Zipcode.can_service_zipcode?(user.zipcode).blank?
            redirect_to shopping_cart_path
          else
            redirect_to landing_page_path("no_service") 
          end
        end
      end
    else
      flash.now[:error] = "We don't recognize those credentials"
      redirect_to login_path
    end
  end

  def destroy
    logout
    session.delete(:shopping_cart_id)
    session.delete(:new_subscriber_id)
    redirect_to login_path
  end

  private
    def redirect_home
      redirect_to dashboard_path unless guest?
    end
end
