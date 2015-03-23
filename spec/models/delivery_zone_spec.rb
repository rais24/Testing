require 'spec_helper'

describe DeliveryZone do
  pending "add some examples to (or delete) #{__FILE__}"
end


describe DeliveryZone do

  it { should have_many(:zipcodes) }
  it { should have_many(:delivery_times) }

  it { should validate_presence_of(:name) }  	

end