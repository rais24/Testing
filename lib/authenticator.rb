class Authenticator < Struct.new(:session, :urls)
  delegate :guest?, to: :current_user, allow_nil: true

  # Public: retrieves the logged in User object, if there is one
  #
  # :from - Optional Hash the overriding session will pull from
  #
  # Returns the User object if present, nil otherwise
  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    #login User.create_guest
  end

  # Public: logs in a `user`
  #
  # :user - the `User` object to set as current
  #
  # :to - Optional Hash the overriding session will pull from
  #
  # Returns the logged in User
  #
  def login(user)
    session[:user_id] = user.try(:id)
    @current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  # Public: logs out the `current_user`.
  #         The `current_user` method will now return `nil`
  def logout
    @current_user = nil
    session.delete(:user_id)
  end
end
