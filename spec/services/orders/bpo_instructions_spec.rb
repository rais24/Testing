require 'spec_helper'

describe Orders::BpoInstructions, '#bpo_instruct!' do
  context 'with an order' do
    let(:order) { build_stubbed :order }

    context 'with one ingredient' do
      let(:store_ingredient) { build_stubbed :store_ingredient }
      let(:order_store_ingredient) { create :order_store_ingredient, store_ingredient: store_ingredient, order: order}
  
      it 'creates instructions ' do
        subject.render.should_not be_nil
      end
  end
end