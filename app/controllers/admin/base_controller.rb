module Admin
  class BaseController < ActionController::Base
    before_filter :ensure_admin
    layout 'admin/base'
    
    # this is also in application_controller, but we dont want cancan here
    delegate :current_user, :guest?, :login, :logout, :logged_in?, to: :authenticator
    
    helper_method :current_user, :logged_in?
    protected
    
    # TODO: refactor common functions into a new base controller
    def authenticator
      @authenticator ||= Authenticator.new(session)
    end
    
    def ensure_admin
      redirect_to "/" and return unless logged_in?
      redirect_to "/" unless current_user.is?(:admin)
    end
  end
end
