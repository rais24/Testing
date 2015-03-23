require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes /login to sessions#new" do
      get("/login").should route_to("sessions#new")
    end

    it "routes /logout to sessions#destroy" do
      get("/logout").should route_to("sessions#destroy")
    end
  end
end
