class SitemapsController < ApplicationController
  skip_load_and_authorize_resource
  skip_before_filter :authenticate

	def index
		@recipes = Recipe.published
    respond_to do |format|
     format.xml
    end
  end

end
