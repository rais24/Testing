require 'spec_helper'

shared_examples_for Servable do
  it_behaves_like Quantifiable

  let!(:relation) do
    described_class.to_s.split(/serving/i).first.downcase.to_sym
  end

  it { should belong_to(:recipe) }
  it { should validate_presence_of(:recipe) }

  it { should belong_to(relation) }
  it { should validate_presence_of(relation) }

  Recipe::MEALS.each do |meal|
    it { expect(described_class).to respond_to meal.pluralize }
  end
end