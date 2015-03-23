class MailingListUsersController < InheritedResources::Base
  skip_load_and_authorize_resource
  
  layout "layouts/lander"
  
  def create
    begin
      gb = Gibbon::API.new
      if params[:user][:found] == "yes"
        list_id = "9ac37244da" # found
        resp = gb.lists.subscribe({:id => list_id, :email => {:email => params[:user][:email]}, :merge_vars => {:ZIPCODE => params[:user][:zipcode]}, :double_optin => true})
      else
        list_id = "d24161bd61" # not found
        resp = gb.lists.subscribe({:id => list_id, :email => {:email => params[:user][:email]}, :merge_vars => {:ZIPCODE => params[:user][:zipcode]}, :double_optin => true})
      end
      
      respond_to do |format|
        format.js {render :nothing => true }
        format.html {}
      end
    rescue Gibbon::MailChimpError => e
      # rescuing if we have an error - most likely already subscribed to list. 
      # for now, just fail silently since were only concerned with capturing emails
      respond_to do |format|
        format.js {render :nothing => true }
        format.html {}
      end
    end
    
  end
end
