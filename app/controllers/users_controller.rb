class UsersController < InheritedResources::Base
  skip_load_and_authorize_resource only: [:new, :create, :welcome, :unlock, :complete]
  helper_method :user_attributes
  skip_before_filter :authenticate, only: [:new]

  def edit
    if current_user.is? :admin
      edit!
    else
      redirect_to registration_path
    end
  end

  def index
    search = (params[:search] || '').strip
    column = sort_column User

    if search && search.length > 0
      legal = user_attributes.include?(params[:search_by])
      legal ? attributes = params[:search_by] : attributes = "first OR last"
      @users = User.where("#{attributes} LIKE ?", "%#{search}%").order("#{column} #{sort_direction}")
    else
      @users = User.registered.order("id")
    end
  end

  def new
  end

  def complete
    @user = current_user
    if @user.update_attributes(params.require(:user).permit(:email,:first,:last,:zipcode,:password,:password_confirmation,:guest))
      redirect_to checkout_path
    else
      flash.now[:error] = "Looks like there were a few errors."
      render :action => 'new'
    end
  end
  
  def resend_activation
    @user = User.find(params[:id])
    
    UserMailer.activation(@user).deliver
    redirect_to index_path
  end

  def create
    create! do |success, failure|
      success.html do
        registrar.register
        login(@user)
        WelcomeWorker.perform_async(@user.id)
        redirect_to checkout_path
      end
    end
  end

  def welcome
    if resource.auth_token == params[:auth_token]
      WelcomeWorker.perform_async(resource.id)
    end
    redirect_to dashboard_path
  end

  def unlock
    if params[:auth_token] == resource.auth_token &&
       resource.update!(locked: false)
      redirect_to registration_path
    else
      redirect_to dashboard_path
    end
  end

  protected
    def begin_of_association_chain
      if @site ||= DeliverySite.find_by(promo_code: params.fetch(:user, {})[:zipcode])
        params.fetch(:user, {})[:zipcode] = @site.zip if @site
      else
        @site ||= DeliverySite.find_by(zip: params.fetch(:user, {})[:zipcode])
      end
      @site
    end

    def registrar
      Users::Registrar.new(current_user, @user, OrderWorker.new)
    end

    def user_attributes
      ["first OR last", "first", "last", "email"]
    end

    def permitted_params
      if current_user.is?(:admin)
        params.permit!
      else
        params.permit user: [:email,
                            :first,
                            :last,
                            :adults,
                            :children,
                            :billing_id,
                            :password,
                            :password_confirmation,
                            :zipcode
                            ]
      end
    end
end
