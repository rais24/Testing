require 'spec_helper'

describe DeliveryTime do

 	it { should belong_to(:order) }
  it { should belong_to(:delivery_zone) }

  #it { should validate_presence_of(:delivery_date) }
  #it { should validate_presence_of(:time_slot) }  	

	context "with same delivery date" do
		let(:order) { create :order }
		subject(:delivery_time) { create :delivery_time, order: order }
		it "should have a time slot, delivery date and order" do
			subject.time_slot.should == "11-1"
			subject.delivery_date.should == Date.today
			subject.order.should == order
		end

		it 'should fail if time slot is more than 2 hours' do
		  subject.time_slot = "11-2"
		  expect{subject.save!}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time slot must be a 2-hour interval')
		end

		it 'should fail if time slot has no ending time' do
		  subject.time_slot = "11-"
		  expect{subject.save!}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time slot must be a 2-hour interval')
		end

		it 'should fail if time slot has no beginning time' do
		  subject.time_slot = "-9"
		  expect{subject.save!}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time slot must be a 2-hour interval')
		end
  end

  context "with 5 delivery times for 5 orders" do
		before(:all) { 
      @delivery_zone = create :delivery_zone
  		4.times do |i| 
        order = create :order, price: i
				delivery_time = create :delivery_time, order: order, delivery_date: Date.today, time_slot: "3-5", delivery_zone_id: @delivery_zone.id
			end
		}
		subject(:delivery_time) { build :delivery_time }

		it 'if more than 4 deliveries are assigned to same slot' do
			order = create :order, price: 7
			subject.order = order
      subject.delivery_zone_id = @delivery_zone.id
			subject.time_slot = "3-5"
			expect{subject.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Sorry we're all booked up for that time. Please select another time to receive your delivery")
		end
		
		it 'if more than 4 deliveries are assigned to the same slot with different zones' do
		  order = create :order, price: 7
		  delivery_zone2 = create :delivery_zone
			subject.order = order
      subject.delivery_zone_id = delivery_zone2.id
			subject.time_slot = "3-5"
			subject.should be_valid
	  end

		it 'if 5th order has different delivery time' do
			subject.time_slot = "1-3"
			expect{subject.save!}.not_to raise_error()
			subject.should be_valid
		end

    it 'if 5th order has different delivery zone' do
      deliver_zone_another = create :delivery_zone, name: "Alt-1", days: "Wednesday"
      subject.delivery_zone_id = deliver_zone_another.id
      expect{subject.save!}.not_to raise_error()
      subject.should be_valid
    end

  end
end
