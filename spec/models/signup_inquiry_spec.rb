require 'spec_helper'

describe SignupInquiry do
  it { should validate_presence_of(:zipcode) }
  it { should validate_uniqueness_of(:email) }

  context "with 100 users for a zipcode" do
  	let(:zipcode) { create :zipcode }
  	before(:all) { 
  		SignupInquiry::MAX_USERS_PER_ZIPCODE.times { user = create :user, zipcode: zipcode.code }
  	}
  	subject(:signup_inquiry) { build :signup_inquiry, zipcode: zipcode.code }
  	it 'should fail if 101st user requests the same zipcode' do
  		subject.can_service_zipcode?.should be_false
  		subject.validation_error.should == "Zipcode #{zipcode.code} already has #{SignupInquiry::MAX_USERS_PER_ZIPCODE} users"
  	end
  end
end
