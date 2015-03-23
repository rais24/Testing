require 'spec_helper'

describe Orders::Router, '#order_route!' do
  context 'with an order' do
  	let(:last_bpo) { build_stubbed :last_bpo }
  	let(:address) { build_stubbed :address }
   	let(:order) { build_stubbed :order, address: address }
   	subject { described_class.new(order) }
  
  	it 'should fail to assign bpo processor without zipcode' do
  		subject.resolve_bpo_processor.should_not be_nil
  	end

  end
end