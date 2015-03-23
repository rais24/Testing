class PasswordResetsController < InheritedResources::Base
  skip_load_and_authorize_resource

  before_filter :verify, only: [:update, :edit]
  skip_before_filter :authenticate

  def create
    user = User.find_by email: params[:email]
    if user.present?
      # reset the clock
      user.password_reset_sent_at = Time.zone.now

      # send the email if the user saves
      UserMailer.password_reset(user).deliver if user.save!

      redirect_to login_path, notice: "Password reset instructions sent to #{user.email}."
    else
      redirect_to collection_path, alert: "User with email '#{params[:email]}' doesn't exist"
    end
  end

  def update
    if sent_at < 2.hours.ago
      redirect_to password_resets_path, alert: "Password reset has expired."
    elsif resource.update(permitted_params[:user])
      login(resource.reload)
      redirect_to recipes_path, notice: "You password has been reset."
    else
      render :edit
    end
  end

  private
    def resource
      @user ||= User.find_by password_reset_token: params[:id]
    end

    def collection
      []
    end

    def sent_at
      resource.password_reset_sent_at || Time.now
    end

    def verify
      redirect_to login_path, alert: "Password Reset failed. Please try again." unless resource
    end

    def permitted_params
      params.permit user: [:password, :password_confirmation]
    end
end
