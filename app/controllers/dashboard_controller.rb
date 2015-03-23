class DashboardController < ApplicationController
  skip_load_and_authorize_resource

  before_filter :authenticate
  
  def layouts
    %i(locked checkout)
  end
end
