module Nutrition
  module References
    module UrlHelpers
      HARVARD_URL  = "http://www.health.harvard.edu/plate/healthy-eating-plate"
      MY_PLATE_URL  = "http://www.choosemyplate.gov/"
      HARVARD_USDA_COMPARE_URL = "http://www.hsph.harvard.edu/nutritionsource/healthy-eating-plate-vs-usda-myplate/"

      def harvard_link_to(linked = "Harvard's Healthy Eating Plate", opts = {target: "_blank"})
        link_to linked, HARVARD_URL, opts
      end

      def usda_link_to(linked = "USDA's MyPlate", opts = {target: "_blank"})
        link_to linked, MY_PLATE_URL, opts
      end

      def harvard_usda_comparison_link_to(linked = "compare the two", opts = {target: "_blank"})
        link_to linked, HARVARD_USDA_COMPARE_URL, opts
      end
    end
  end
end