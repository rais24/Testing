require 'spec_helper'

describe RecipePortion do
  it_behaves_like Portionable
  it_behaves_like Measureable
end

describe RecipePortion, 'validations' do
  it { should belong_to(:recipe) }
  it { should validate_presence_of(:recipe) }
  it { should belong_to(:ingredient) }
  it { should validate_presence_of(:ingredient) }
end

describe RecipePortion, 'scopes' do
  %i(published unpublished).each do |scope|
    it "has scope ::#{scope}" do
      expect(described_class).to respond_to scope
    end
  end
end