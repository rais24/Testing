module Servable
  extend ActiveSupport::Concern

  include Quantifiable

  included do
    belongs_to :recipe
    validates_presence_of :recipe

    delegate :name, :photo, :meal, to: :recipe, allow_nil: true

    Recipe::MEALS.map(&:pluralize).each do |meal|
      scope meal, ->{ joins(:recipe).merge(Recipe.send(meal)) }
    end
  end
end