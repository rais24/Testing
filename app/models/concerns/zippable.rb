module Zippable
  extend ActiveSupport::Concern
  include GoingPostal

  COUNTRY_CODES = %w(US CA GB IE CH AU NL)

  included do
    # recalculate the price if its unset
    validates_each :zipcode, if: :validate_zip? do |model, attr, value|
      found = COUNTRY_CODES.reduce(nil) do |zip, country|
        zip || GoingPostal.postcode?(value, country)
      end
      unless found.present?
        model.errors.add(attr, 'must be a valid postal code')
      end
    end
  end

  def validate_zip?
    true
  end
end