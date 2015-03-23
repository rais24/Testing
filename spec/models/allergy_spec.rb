require 'spec_helper'

describe Allergy do
  it { should validate_uniqueness_of(:name) }
  it { should have_and_belong_to_many(:users) }
end
