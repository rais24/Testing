require 'spec_helper'

describe Users::Registrar, '#register' do
  let(:from_user){ build_stubbed :user, :guest }
  let(:site) { build_stubbed :delivery_site }
  let(:serving_count) { 1 }
  let(:recipe) { build_stubbed :recipe }
  let(:servings) { create_list :order_serving, serving_count, recipe: recipe, order: orders.first }
  let(:orders) { create_list :order, 1 }
  let(:to_user){ create :user, site: site, orders: orders }
  let(:worker){ double :worker }

  let(:scheduler) { double :scheduler, week_of: orders.first }

  subject { described_class.new(from_user, to_user, worker) }

  before do
    expect(from_user.orders).to receive(:last) { orders.first }
    expect(to_user).to receive(:update!).with(locked: servings.empty?)
    expect(worker).to receive(:perform)
  end

  # context 'with user who populated an order' do
  # 
  #   context 'its user' do
  #     it 'is unlocked' do
  #       expect(subject.register.reload).not_to be_locked
  #     end
  #   end
  # end

  context 'with a user with an empty order' do
    let(:serving_count) { 0 }

    context 'its user' do
      it 'is locked' do
        expect(subject.register.reload).to be_locked
      end
    end
  end
end