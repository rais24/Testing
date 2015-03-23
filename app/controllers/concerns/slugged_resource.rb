module SluggedResource
  extend ActiveSupport::Concern

  included do
    defaults finder: :find_by_id_or_slug!
  end
end