require 'spec_helper'

describe Orders::Scheduler, '#schedule!' do
  let(:orders) { double :orders }
  let(:site) { nil }
  let(:date) { Time.now.next_week(:thursday) }
  let(:week) { Delivery.range(date) }
  subject { described_class.new(orders, site) }

  context 'when an order is already scheduled for a week' do
    let(:order){ build_stubbed :order }
    before do
      expect(orders).to receive(:week_of) { double first: order }
    end

    it 'raises an Error' do
      date = Time.now.next_week(:thursday)
      order = build_stubbed :order, scheduled_for: date.beginning_of_week
      expect{ subject.schedule!(date) }.to raise_error Orders::ConflictError
    end
  end

  context 'without a conflicting order scheduled' do
    let(:site) { build_stubbed :delivery_site }
    let(:relation) { double :week_of, to: double(first: nil), first: nil }

    before do
      expect(relation).to receive(:to) { relation }

      expect(orders).to receive(:week_of) { relation }
    end

    it 'creates an order' do
      date = Time.now
      friday = Delivery.next
      created = build_stubbed :order, delivered: false, scheduled_for: friday
      expect(orders).to receive(:create!)
                .with(scheduled_for: friday, site: site) { created }

      created = subject.schedule!(date)
      expect(created).not_to be_delivered
      expect(created.scheduled_for).to be_friday
    end
  end
end

describe Orders::Scheduler, '#week_of' do
  let(:orders) { double :orders }
  let(:site) { nil }
  let(:date) { Time.now.next_week(:thursday) }
  let(:week) { Delivery.range(date) }
  subject { described_class.new(orders, site) }

  context 'given a date in a week with an order' do
    let(:order) { build_stubbed :order }
    before do
      expect(orders).to receive(:week_of) { double first: order }
    end

    it 'retrieves the order' do
      expect(subject.week_of(date)).not_to be_nil
    end
  end

  context 'given a date in a week without a order' do
    before do
      expect(orders).to receive(:week_of) { double first: nil }
    end
    it 'returns nil' do
      expect(subject.week_of(date)).to be_nil
    end
  end
end