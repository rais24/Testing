module Slugged
  extend ActiveSupport::Concern

  included do
    validates_uniqueness_of :slug

    before_validation :generate_slug

    def to_param
      slug
    end

    def generate_slug
      self.slug ||= name.try(:parameterize)
    end
  end

  module ClassMethods
    def find_by_id_or_slug!(slug)
      id = slug.to_i
      if id > 0
        find(id)
      else
        find_by! slug: slug
      end
    end
  end
end