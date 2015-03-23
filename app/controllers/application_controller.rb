class ApplicationController < ActionController::Base
  respond_to :html, :js, :json

  before_filter :authenticate
#  before_filter :strict_transport_security
  
  include Pagination

  helper SocialMedia::UrlHelpers
  helper Nutrition::References::UrlHelpers

  protect_from_forgery
  load_and_authorize_resource

  helper_method :site, :layouts, :sort_direction, :cart
  helper_method :current_user
  helper_method :sort_column
  helper_method :display_cart?
  helper_method :logged_in?

  delegate :current_user, :guest?, :login, :logout, :logged_in?, to: :authenticator

  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:denied_request] = request.url
    denied_page = login_url
    redirect_to denied_page, alert: exception.message
  end

  protected
    # Public: checks if there is a `current_user` logged in,
    #         and will bounce traffic otherwise. If a user is logged in
    #         but locked, they'll be directed to the dashboard
    def authenticate
      # if the user is locked and not already headed to the dashboard,
      # put them there
      # if guest?
      #   redirect_if_not new_order_path
      # elsif current_user.locked?
      #   redirect_if_not dashboard_path
      # elsif !current_user.active?
      #   redirect_if_not registration_path
      # end
      target_url = is_specialist? ? login_url(user_type: "spec") : login_url
      unless logged_in?
        redirect_if_not target_url
      end
    end

    def is_specialist?
      params[:user_type] && params[:user_type] == "spec"
    end

    def strict_transport_security
      if request.ssl?
        response.headers['Strict-Transport-Security'] = "max-age=31536000; includeSubDomains"
      else
        response.headers['Strict-Transport-Security'] = "max-age=0;"
      end
    end

    def display_cart?
      can? :read, Order
    end

    def redirect_if_not(path)
      if request.path != path
        redirect_to path
      end
    end

    def next_order(user = current_user)
      unless @next_order
        scheduler = Orders::Scheduler.new(user.orders, user.site)
        @next_order = scheduler.week_of || scheduler.schedule!
      end
      @next_order
    end

    def cart
      @cart = ShoppingCart.find(session[:shopping_cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = ShoppingCart.create(user: current_user)
      session[:shopping_cart_id] = @cart.id
      @cart
    end

    def new_subscriber
      return User.find_by(email: session[:new_subscriber_id]) unless session[:new_subscriber_id].blank?
      nil
    rescue
      nil
    end

    def layouts
      []
    end

    def sort_column(klass)
      columns = klass.column_names
      if columns.include?(params[:sort])
        params[:sort]
      else
        columns.first
      end
    end

    def sort_direction
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        "asc"
      end
    end

    def update_order(order)
      order.calculate_price!
      OrderWorker.new.perform(order.id)
    end

    def authenticator
      @authenticator ||= Authenticator.new(session)
    end

    def store_location
      session[:return_to] = request_path || request.referer
    end

    def stored_location
      session[:return_to] || recipes_path
    end
end
