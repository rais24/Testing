module SocialMedia
  module UrlHelpers
    FACEBOOK_URL  = "https://www.facebook.com/pages/Fitly-Making-eating-healthy-fun-for-kids/254561257918450"
    TWITTER_URL   = "https://twitter.com/fitlyfamily"
    PINTEREST_URL = "https://pinterest.com/thefitlyfamily/"
    INSTAGRAM_URL = "https://instagram.com/fitlyfamily/"
    BLOGGER_URL   = "https://fitlyfamily.blogspot.com/"
    INDIEGOGO_URL = "http://igg.me/at/fitly"

    def facebook_link_to(linked = "Facebook", opts = {target: "_blank"})
      link_to linked, FACEBOOK_URL, opts
    end

    def twitter_link_to(linked = "Tweet Us", opts = {target: "_blank"})
      link_to linked, TWITTER_URL, opts
    end

    def pinterest_link_to(linked = "Pin Us", opts = {target: "_blank"})
      link_to linked, PINTEREST_URL, opts
    end

    def instagram_link_to(linked = "Instagram Us", opts = {target: "_blank"})
      link_to linked, INSTAGRAM_URL, opts
    end

    def blogger_link_to(linked = "Checkout Our Blog", opts = {target: "_blank"})
      link_to linked, BLOGGER_URL, opts
    end

    def indiegogo_link_to(linked = "Support Our Campaign", opts = {target: "_blank"})
      link_to linked, INDIEGOGO_URL, opts
    end
  end
end