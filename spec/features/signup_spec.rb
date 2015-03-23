require 'spec_helper'

describe "Signup from Landing Page", type: :feature do
  describe "getting started" do
    it "links to new Order page" do
      %w(headerCarousel how-it-works).each do |container|
        visit root_path

        within "##{container}" do
          find(".cta").click
        end

        expect(current_path).to eq(new_order_path)
      end
    end
  end
end