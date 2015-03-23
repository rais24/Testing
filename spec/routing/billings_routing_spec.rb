require "spec_helper"

describe BillingsController do
  describe "routing" do

    it "routes to #show" do
      get("/billing").should route_to("billings#show")
    end

    it "routes to #new" do
      get("/billing/new").should route_to("billings#new")
    end

    it "routes to #edit" do
      get("/billing/edit").should route_to("billings#edit")
    end

    it "routes to #create" do
      post("/billing").should route_to("billings#create")
    end

    it "routes to #update" do
      put("/billing").should route_to("billings#update")
    end

    it "routes to #destroy" do
      delete("/billing").should route_to("billings#destroy")
    end

  end
end
