require 'spec_helper'

describe DeliverySite do
  it { should have_many(:users) }
  it { should have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:promo_code) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_uniqueness_of(:promo_code) }

  it { should have_attached_file(:logo) }
end
