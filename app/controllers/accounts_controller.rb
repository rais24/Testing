class AccountsController < ApplicationController
  skip_load_and_authorize_resource
  before_filter :authenticate
  before_filter :full_user
  before_filter :resolve_user_group, :only => [:update]
  before_filter :apply_promo_code, :only => [:update]
  layout false, only: [:show, :edit, :show_patients]

  def show
    @user = User.find(params[:user_id]) unless params[:user_id].blank?
    @user ||= current_user 
    redirect_to show_patients_account_path if @user.is_specialist?
    # Fawad ToDo: prevent non-assigned practitioner from viewing patient 
    if @user.subscription && @user.practitioner_code
      @dietician = User.where(role: "spec", encrypted_practitioner_code: @user.encrypted_practitioner_code).first
    end
    render "accounts/#{params[:page_type]}" if params[:page_type]
  end

  def show_patients
    @user = current_user 
    # Fawad ToDo: prevent patients from seeing this practitioner's patients
    @patients = User.includes(:subscription).where(["role = '' AND encrypted_practitioner_code is not null AND encrypted_practitioner_code = ?", current_user.encrypted_practitioner_code])
  end

  def edit
    #@user = User.find(params[:user_id]) unless params[:user_id].blank?
    #@user ||= current_user 
    @user = current_user 
    if params[:plan]
      plan_type = params[:plan]
      if @user.subscription
        @user.subscription.subscription_type = "#{plan_type}-day"
      else
        @user.build_subscription({subscription_type: "#{plan_type}-day", expires_on: Chronic.parse("6 weeks hence"), status: "new", delivery_day: "", delivery_time_slot: ""})
      end
      @user.save!
    end
    case params[:page_type]
    when "billing"
      @user.build_billing unless @user.billing
      @user.billing.build_address unless @user.billing.address
    end
    # Fawad ToDo: prevent patients from seeing this practitioner's patients
    render "accounts/edit_#{params[:page_type]}" if params[:page_type]
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:dietary_needs,:targets,:billing, :progress_history,:nutrition_goals,:dietary_willingness,:dietary_preferences,:dietary_dislikes,:email,:name,:first,:last,:business_name,:zipcode,:password,:password_confirmation,:guest,:invite_code,:ok_to_email,:practitioner_code,:height_ft,:height_inch,:weight,:gender,:dob,:ok_to_discuss_with_dietician,:insurer,:phone,:certificate_type,:certificate_number,:address,:state)
      .tap do |whitelisted|
        whitelisted[:targets] = params[:user][:targets]
        whitelisted[:progress_history] = params[:user][:progress_history]
        whitelisted[:medical_history] = params[:user][:medical_history]
        whitelisted[:billing] = param[:user][:billing]
      end
    if user_params[:dietary_needs].present?
      @user.record_dietary_needs(user_params[:dietary_needs])
      @user.save!
      redirect_to edit_account_path(page_type: "preferences")
    elsif user_params[:dietary_preferences].present?
      @user.record_dietary_preferences(user_params[:dietary_preferences])
      @user.save!
      redirect_to edit_account_path(page_type: "dislikes")
    elsif user_params[:dietary_willingness].present?
      @user.record_willingness_to_change(user_params[:dietary_willingness])
      @user.save!
      redirect_to edit_account_path(page_type: "medical_history")      
    elsif user_params[:medical_history].present?
      @user.record_medical_history(user_params[:medical_history])
      @user.save!
      redirect_to edit_account_path(page_type: "nutrition_goals")      
    elsif user_params[:targets].present? || user_params[:progress_history].present?
      @user.record_targets(user_params[:targets])
      @user.record_progress_history(user_params[:progress_history])
      @user.save!
      redirect_to account_path  
    elsif user_params[:nutrition_goals].present?
      @user.nutrition_goals = user_params[:nutrition_goals]
      @user.save!
      redirect_to account_path
    elsif user_params[:dietary_dislikes].present?
      @user.dietary_dislikes = user_params[:dietary_dislikes]
      @user.save!
      redirect_to account_path
    elsif  params[:billing].present?    
      @user.build_billing unless @user.billing
      @user.billing.build_address unless @user.billing.address
      update_billing_profile user_params[:billing]
      redirect_to edit_account_path(page_type: "delivery_info")    
    else
      @user.update_user_info(user_params)
      @user.update_attributes(params.require(:user).permit(:password, :password_confirmation)) unless params[:password].blank? && params[:password_confirmation].blank?
      resolve_user_group
      apply_promo_code
      redirect_to account_path
    end
  end

  protected
  
  def update_billing_profile billing_params
    if billing_params[:expiration_date]
      expiration_month, expiration_year = billing_params[:expiration_date].split("/")
      billing_params[:expiration_month] = expiration_month.strip
      billing_params[:expiration_year] = expiration_year.strip
    end
    if @user.billing
      @user.billing.update!(billing_params.except(:expiration_date, :address, :city, :state, :zipcode))
    else
      @user.create_billing!(creditcard_params.except(:expiration_date, :address, :city, :state, :zipcode))
    end
    @user.save!
    update_billing_address_profile(billing_params)
  end

  def update_billing_address_profile address_params
    first_name, last_name = @user.billing.name.split(" ")
    address_params.merge!({first_name: first_name, last_name: last_name, street1: address_params[:street]})
    if @user.billing.address
      @user.billing.address.update!(address_params.slice(:first_name, :last_name, :street1, :city, :state, :zipcode))
    else
      @user.billing.create_address!(address_params.slice(:first_name, :last_name, :street1, :city, :state, :zipcode))
    end
    @user.save!
  end

  def resolve_user_group
    unless account_params[:user].blank?
      @user = current_user
      invite_code = account_params[:user][:invite_code]
      if invite_code.blank?
        @user.user_group = nil 
        @user.save
      elsif invite_code != @user.invite_code
        user_group = UserGroup.find_by_code(invite_code)
        if user_group
          @user.user_group = user_group 
          @user.save
        end
      end
    end
  end

  def apply_promo_code
    unless account_params[:user].blank?
      invite_code = account_params[:user][:invite_code]
      promo = Promo.find_by_code(invite_code)
      cart.add_promo(promo) if promo
    end
  end

  def full_user
    redirect_to login_path if current_user.guest?
  end

  def account_params
    params.permit user: [:password, :password_confirmation, :email, :first, :last, :invite_code, :heart_healthy, :prevent_diabetes, :gluten_free]
  end

end
