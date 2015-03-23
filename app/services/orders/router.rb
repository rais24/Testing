module Orders
  class Router < Struct.new(:order)
    def resolve_bpo_processor
      # first get assigned bpos for this zipcode      
      return nil if order.address.blank? || order.address.zipcode.blank?

      zip_code = Zipcode.find_by(code: order.address.zipcode)
      return nil if zip_code.blank?

      bpo_store = zip_code.stores.first unless zip_code.stores.empty?      
      return nil if bpo_store.blank?

      BpoProcessor.create! order: order, store: bpo_store
    end
  end
end