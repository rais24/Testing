module Routing
  module AdminConstraint
    def self.matches?(request)
      user_from_session(request.session).is? :admin
    end

    private
      def self.user_from_session(session)
        Authenticator.new(session).current_user
      end
  end
end