require 'csv'

class ImportIngredients
  def self.import csv
    CSV.foreach(csv, headers: true) do |row|
      i = StoreIngredient.new row.to_hash.reject{|k,v| k=='product url' || k=='price'}
      i.price = Money.new(row.to_hash['price'])
      
      i.save!
    end
  end
end
