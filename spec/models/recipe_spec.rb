require 'spec_helper'

describe Recipe do
  it_behaves_like Slugged do
    subject { create :recipe }
  end
  
  subject { build_stubbed :recipe }
  
  it { should have_many(:portions).dependent(:destroy) }
  it { should have_many(:ingredients).through(:portions) }

  it { should have_many(:order_servings).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:preparation) }
  it { should validate_numericality_of(:prep_time).is_greater_than_or_equal_to(0) }

  Recipe::MEALS.each do |meal|
    it { should allow_value(meal).for(:meal) }
    it { expect(described_class).to respond_to(meal.pluralize) }
  end

  it { should have_attached_file(:photo) }
end
