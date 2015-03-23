require 'spec_helper'

describe OrderConfirmationsController do

  describe "GET 'create'" do
    it "returns http success" do
      post 'create', { :recipient => 'orders@mg.fitly.org', 
                       "body-html" => "html stuff", 
                       :timestamp => 1394118263,
                       :format => "json"  
                      }
      response.should be_success
    end
  end

end