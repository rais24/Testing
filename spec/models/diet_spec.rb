require 'spec_helper'

describe Diet do
  it { should validate_uniqueness_of(:name) }
  it { should have_and_belong_to_many(:users) }
end
