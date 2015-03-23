require "spec_helper"

describe DeliverySitesController do
  describe "routing" do

    it "routes to #index" do
      get("/sites").should route_to("delivery_sites#index")
    end

    it "routes to #new" do
      get("/sites/new").should route_to("delivery_sites#new")
    end

    it "routes to #show" do
      get("/sites/1").should route_to("delivery_sites#show", id: "1")
    end

    it "routes to #edit" do
      get("/sites/1/edit").should route_to("delivery_sites#edit", id: "1")
    end

    it "routes to #create" do
      post("/sites").should route_to("delivery_sites#create")
    end

    it "routes to #update" do
      put("/sites/1").should route_to("delivery_sites#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/sites/1").should route_to("delivery_sites#destroy", id: "1")
    end

  end
end
