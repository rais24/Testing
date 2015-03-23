require "spec_helper"

describe ZipcodesController do
  describe "routing" do

    it "routes to #index" do
      get("/zipcodes").should route_to("zipcodes#index")
    end

    it "routes to #new" do
      get("/zipcodes/new").should route_to("zipcodes#new")
    end

    it "routes to #show" do
      get("/zipcodes/1").should route_to("zipcodes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/zipcodes/1/edit").should route_to("zipcodes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/zipcodes").should route_to("zipcodes#create")
    end

    it "routes to #update" do
      put("/zipcodes/1").should route_to("zipcodes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/zipcodes/1").should route_to("zipcodes#destroy", :id => "1")
    end

  end
end
