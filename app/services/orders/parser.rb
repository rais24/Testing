require 'nokogiri'
module Orders
  class Parser
    attr_accessor :raw

    def initialize raw
      @raw = raw
    end
    # parse raw html into something usable
    def parse
      obj = []
      parsed = Nokogiri::HTML(@raw)
      parsed.css("tr").each do |r|
        unless r.css("td").select{|t| t["width"] == "5%"}.empty? || r.css("td").select{|t| t["width"] == "45%"}.empty?
          unless r.css("td").select{|t| t["width"] == "5%"}[0].text.gsub(/\s+/, "").blank?
            obj <<  { quantity: r.css("td").select{|t| t["width"] == "5%"}[0].text.gsub(/\s+/, "").to_i,
                      name: r.css("td").select{|t| t["width"] == "45%"}[0].text.gsub(/\s/, '').gsub(/\p{Z}/,'') }
          end
        end
      end
      obj
    end

    def get_order
      order = /order\s\#(\d*)/.match(@raw)
      order[1].to_i # order id
    end
  end
end
