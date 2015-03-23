class SignupController < InheritedResources::Base
  skip_load_and_authorize_resource
  skip_before_filter :authenticate

  NON_HEALTHCARE_ACTIONS = [:new, :zipcode_check, :index, :visitor, :create, :complete, :update, :queue_signup_inquiry]
  layout "layouts/application", only: NON_HEALTHCARE_ACTIONS
  layout "layouts/healthcare/hc_application", except: NON_HEALTHCARE_ACTIONS
  before_filter :determine_specialty, except: NON_HEALTHCARE_ACTIONS

  def new
    @signup_inquiry = SignupInquiry.new
  end

  def zipcode_check
    @signup_inquiry = SignupInquiry.new
  end

  def index
  	@signup_inquiry = SignupInquiry.new
    session[:return_to] = recipes_path
    render :layout => false
  end

  def visitor
    @user = User.new
  end

  def create
    @signup_inquiry = SignupInquiry.new(signup_params[:signup_inquiry].except(:new_user))
    if @signup_inquiry.can_service_zipcode?
      flash[:availability] = "<strong>Awesome!</strong> Fitly is available in your area, so let's get cooking!".html_safe
      if signup_params[:signup_inquiry][:new_user] == "true"
        redirect_to visitor_signup_path
      else
        login(User.create_guest(@signup_inquiry.zipcode))
        #redirect_to complete_signup_path
        if cart.is_empty?
          redirect_to recipes_path
        else
          redirect_to shopping_cart_path
        end      
      end
    elsif @signup_inquiry.validation_error == "Zipcode not provided"
      render :index, :layout => false
    else
      #@signup_inquiry.submit_to_mail_chimp
      render :signup_failure
    end
  end

  def complete
    @user = current_user
  end

  def signup_newsletter
    signup_user_for_email_letter(params[:user][:email]) unless params[:user][:email].blank?
    render :layout => false
  end

  def update
    @user = current_user || User.new
    if @user.update_attributes(params.require(:user).permit(:email,:first,:last,:zipcode,:password,:invite_code, :password_confirmation,:guest,:ok_to_email))
      signup_user_for_email_letter(@user.email) if params[:user][:ok_to_email] == "1"
      login(@user)
      redirect_to shopping_cart_path
    else
      render action: :complete
    end
  end

  def queue_signup_inquiry
    @signup_inquiry = SignupInquiry.new(signup_params[:signup_inquiry].except(:new_user))
    unless @signup_inquiry.save
      render :signup_failure
    end
  end

  def weightloss_landing
    signup_medical_landing
  end

  def weightloss_inquiry
    signup_medical_visitor
  end

  def diabetes_landing
    signup_medical_landing
  end

  def diabetes_inquiry
    signup_medical_visitor
  end

  def diabetes_type2_landing
    signup_medical_landing
  end

  def diabetes_type2_inquiry
    signup_medical_visitor
  end

  def pre_diabetes_landing
    signup_medical_landing
  end

  def pre_diabetes_inquiry
    signup_medical_visitor
  end

  def gluten_free_landing
    signup_medical_landing
  end

  def gluten_free_inquiry
    signup_medical_visitor
  end

  def hypertension_landing
    signup_medical_landing
  end

  def hypertension_inquiry
    signup_medical_visitor
  end

  def crohns_disease_landing
    signup_medical_landing
  end

  def crohns_disease_inquiry
    signup_medical_visitor
  end

  def heart_disease_landing
    signup_medical_landing
  end

  def heart_disease_inquiry
    signup_medical_visitor
  end

  def gastric_bypass_landing
    signup_medical_landing
  end

  def gastric_bypass_inquiry
    signup_medical_visitor
  end

  def kidney_disease_landing
    signup_medical_landing
  end

  def kidney_disease_inquiry
    signup_medical_visitor
  end

  def renal_disease_landing
    signup_medical_landing
  end

  def renal_disease_inquiry
    signup_medical_visitor
  end

  protected

  private

    def signup_user_for_email_letter user_email
      begin
        gb = Gibbon::API.new
        list_id = "0b1ec2651a"
        resp = gb.lists.subscribe({:id => list_id, :email => {:email => user_email}})
      rescue Gibbon::MailChimpError => e
        Rails.logger.warn "****************************"
        Rails.logger.warn e.message
        Rails.logger.warn "****************************"
      end
    end

    def already_logged_in
      redirect_to recipes_path if current_user
    end

    def determine_specialty
      @specialty = action_name.gsub(/_landing|_inquiry/,"")
      @specialty_signup_link = "/signup/#{@specialty}_inquiry"
    end

    def signup_params
      params.permit signup_inquiry: [:zipcode, :invite_code, :email, :new_user]
    end

    def signup_medical_landing
      @user = User.new
      session[:return_to] = recipes_path
      render "signup/custom/#{@specialty}_landing"
    end

    def signup_medical_visitor
      @signup_inquiry = SignupInquiry.create(zipcode: params[:user][:zipcode], email: params[:user][:email], invite_code: params[:user].fetch(:invite_code, ""))
      user_params = params.require(:user).permit(:email,:first,:last,:zipcode,:password,:invite_code, :password_confirmation,:guest,:ok_to_email)
      unless user_params[:email].blank?
        @user = User.new(
            email: user_params[:email], 
            first: user_params[:first], 
            last: user_params[:last], 
            zipcode: user_params[:zipcode],
            password: user_params[:password], 
            invite_code: user_params[:invite_code],
            password_confirmation: user_params[:password_confirmation],
            ok_to_email: user_params[:ok_to_email],
            guest: user_params[:guest]
          )
          @user.signup_source_list << @specialty
        if @user.save
          if params[:user][:ok_to_email] == "1"
            begin
              gb = Gibbon::API.new
              list_id = "0b1ec2651a"
              resp = gb.lists.subscribe({:id => list_id, :email => {:email => @user.email}})
            rescue Gibbon::MailChimpError => e
              Rails.logger.warn "****************************"
              Rails.logger.warn e.message
              Rails.logger.warn "****************************"
            end
          end
          login(@user)
          render "signup/custom/thank_you"
        else
          render "signup/custom/#{@specialty}_landing"
        end
      else
        render "signup/custom/#{@specialty}_landing"
      end
    end

end
