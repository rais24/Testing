class SubscriptionController < ApplicationController
  include Wicked::Wizard
  include SubscriptionHelper

  layout :false

  skip_load_and_authorize_resource
  skip_before_filter :authenticate

  steps :signup, :billing, :delivery_address, :review, :dietary_needs, :dietary_preferences, :dietary_dislikes, :willingness_to_change, :medical_history, :nutrition_goals, :track_progress, :practitioner_confirmation, :signup_nosubscriber_review, :preferences_saved

  def show
    case step
    when :signup
      @signup_request = new_subscriber || SignupRequest.new
      @signup_request.is_specialist = is_specialist? ? true : false
      plan_type = params[:plan]
      @signup_request.subscription_type = "#{plan_type}-day" if plan_type && MealPlan::SUPPORTED_PLANS.include?(plan_type.to_i)
    when :billing
      @signup_request = SignupRequest.new
      @user = new_subscriber
      login(@user)
      @user.build_billing unless @user.billing
      @user.billing.build_address unless @user.billing.address
      initialize_signup_request_for_billing
    when :delivery_address
      @signup_request = SignupRequest.new
      @user = new_subscriber
      @user.build_weekly_delivery_schedule unless @user.weekly_delivery_schedule
      initialize_signup_request_for_delivery
    when :review
      @user = new_subscriber || User.new
    when :dietary_needs
      @signup_request = SignupRequest.new
      @user = new_subscriber
      @signup_request.dietary_needs_list = @user.dietary_needs_list
    when :dietary_preferences
      @signup_request = SignupRequest.new
      @user = new_subscriber
      @signup_request.dietary_preferences_list = @user.dietary_preferences_list
    when :dietary_dislikes
      @dietary_dislikes = Question.dietary_dislikes
      @user = new_subscriber || User.new
    when :willingness_to_change
      @dietary_dislikes = Question.dietary_dislikes
      @user = new_subscriber || User.new
    when :medical_history
      @dietary_dislikes = Question.dietary_dislikes
      @user = new_subscriber || User.new
    when :nutrition_goals
      @dietary_dislikes = Question.dietary_dislikes
      @user = new_subscriber || User.new
    when :track_progress
      @dietary_dislikes = Question.dietary_dislikes
      @user = new_subscriber || User.new
    when :practitioner_confirmation
      @user = new_subscriber || User.new
    when :signup_nosubscriber_review
      @user = new_subscriber || User.new
    when :preferences_saved
      @user = new_subscriber || User.new      
    end

    if step == Wicked::FINISH_STEP
      #checkout.checkout
    end
    render_wizard
  end

  def update
    case step
    when :signup
      # Getting data from model
      @signup_request = new_subscriber || SignupRequest.new
      signup_params = params.require(:signup_request).permit(:email,:first,:last,:business_name,:zipcode,:password,:password_confirmation,:guest,:invite_code,:ok_to_email,:practitioner_code,:height_ft,:height_inch,:weight,:gender,:dob,:ok_to_discuss_with_dietician,:insurer,:phone,:certificate_type,:certificate_number,:address,:state, :is_specialist, :subscription_type)
      @user = User.find_by(email: signup_params[:email]) || User.new
      @user.update_user_info(signup_params)
      unless @user.is_specialist?
        resolve_user_group(signup_params)
        apply_promo_code(signup_params)
      else
      # Getting data from model again
        @user.practitioner_code = @user.certificate_number if @user.practitioner_code.blank?
        address_params = params[:signup_request].require(:address).permit(:phone, :street, :city, :phone, :state)
        @user.save!
        @user.create_address(first_name: @user.first, last_name: @user.last, zipcode: @user.zipcode, street1: address_params[:street], city: address_params[:city], state: address_params[:state], phone: address_params[:phone])
      end
      if !@user.is_specialist? && params[:signup_request][:subscription_type].present?
        @user.build_subscription({subscription_type: params[:signup_request][:subscription_type], expires_on: Chronic.parse("6 weeks hence"), status: "new", delivery_day: "", delivery_time_slot: ""})
      end
      session[:new_subscriber_id] = @user.email
      if @user.is_subscriber?
        render_wizard @user and return
      elsif @user.is_specialist?
        @user.save!
        login(@user)
        jump_to(:practitioner_confirmation) 
      else
        @user.save!
        login(@user)
        jump_to(:signup_nosubscriber_review)
      end
    when :billing
      @user = new_subscriber || User.new
      creditcard_params = params.require(:signup_request).permit(:card_number,:card_code,:expiration_date,:expiration_month,:expiration_year,:name)
      if creditcard_params[:expiration_date]
        expiration_month, expiration_year = creditcard_params[:expiration_date].split("/")
        creditcard_params[:expiration_month] = expiration_month.strip
        creditcard_params[:expiration_year] = expiration_year.strip
      end
      if @user.billing
        @user.billing.update!(creditcard_params.except(:expiration_date))
      else
        @user.create_billing!(creditcard_params.except(:expiration_date))
      end
      @user.save!
      billing_address_params = params.require(:signup_request).permit(:street,:city,:zipcode,:state)
      first_name, last_name = @user.billing.name.split(" ")
      billing_address_params.merge!({first_name: first_name, last_name: last_name, street1: billing_address_params[:street]})
      if @user.billing.address
        @user.billing.address.update!(billing_address_params.except(:street))
      else
        @user.billing.create_address!(billing_address_params.except(:street))
      end
      render_wizard @user and return
    when :delivery_address
      @user = new_subscriber || User.new
      delivery_params = params.require(:signup_request).permit(:delivery_day, :delivery_instructions, :time_slot)
      #schedule_params = params.require(:subscription).require(:weekly_delivery_schedule_attributes).permit(:delivery_day,:time_slot,:delivery_instructions)
      #@user.subscription.create_weekly_delivery_schedule(schedule_params)
      @user.create_weekly_delivery_schedule(delivery_params)
      @user.save!
      render_wizard @user and return
    when :review
      @user = new_subscriber || User.new
      render_wizard @user and return
    when :dietary_needs
      @user = new_subscriber || User.new
      @user.record_dietary_needs params[:dietary_needs]
      render_wizard @user and return
    when :dietary_preferences
      @user = new_subscriber || User.new
      @user.record_dietary_preferences params[:dietary_preferences]
      render_wizard @user and return
    when :dietary_dislikes
      @user = new_subscriber || User.new
      @user.dietary_dislikes = params[:dietary_dislikes]
      if @user.is_subscriber?
        render_wizard @user and return
      else
        @user.save!
        jump_to(:preferences_saved)
      end
    when :willingness_to_change
      @user = new_subscriber || User.new
      @user.record_dietary_profile params[:dietary_dislikes]
      render_wizard @user and return
    when :medical_history
      @user = new_subscriber || User.new
      @user.record_dietary_profile params[:dietary_dislikes]
      render_wizard @user and return
    when :nutrition_goals
      @user = new_subscriber || User.new
      @user.record_dietary_profile params[:dietary_dislikes]
      render_wizard @user and return
    when :track_progress
      @user = new_subscriber || User.new
      @user.record_dietary_profile params[:dietary_dislikes]
      render_wizard @user and return
    when :practitioner_confirmation
      @user = new_subscriber || User.new
      @user.record_dietary_profile params[:dietary_dislikes]
      render_wizard @user and return
    end
    render_wizard
  end

  def finish_wizard_path
    checkout.finish_checkout_path(current_user)
  end

  protected

    def apply_promo_code signup_params
      invite_code = signup_params[:invite_code]
      promo = Promo.find_by_code(invite_code)
      cart.add_promo(promo) if promo
    end

    def resolve_user_group signup_params
      invite_code = signup_params[:invite_code]
      user_group = UserGroup.find_by_code(invite_code)
      if user_group
        @user.user_group = user_group 
        @user.save!
      end
    end

  private

    def initialize_signup_request_for_delivery
      @signup_request.delivery_day = @user.weekly_delivery_schedule.delivery_day
      @signup_request.time_slot = @user.weekly_delivery_schedule.time_slot
      @signup_request.delivery_instructions = @user.weekly_delivery_schedule.delivery_instructions
    end

    def initialize_signup_request_for_billing
      @signup_request.name = @user.name
      @signup_request.card_number = @user.billing.card_number
      @signup_request.expiration_date = @user.billing.expiration_date
      @signup_request.card_code = @user.billing.card_code
      @signup_request.name = @user.billing.name
      @signup_request.street = @user.billing.address.street1
      @signup_request.city = @user.billing.address.city
      @signup_request.zipcode = @user.billing.address.zipcode
    end

end
