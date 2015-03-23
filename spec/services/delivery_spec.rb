require 'spec_helper'

describe Delivery, '#next' do
  it 'is a Friday' do
    expect(Delivery.next).to be_friday
  end

  context 'when Today is Friday' do
    let(:today) { Time.now.next_week(:friday) }

    it 'delivery is Today' do
      expect(Delivery.next(today).to_date).to eq today.to_date
    end
  end

  context 'when Today is Thursday' do
    let(:today) { Time.now.next_week(:thursday) }

    it 'delivery is Tomorrow' do
      expected = today + 1.day
      expect(Delivery.next(today).to_date).to eq expected.to_date
    end
  end

  context 'when Today is Saturday' do
    let(:today) { Time.now.next_week(:saturday) }

    it 'delivery is next Friday' do
      expected = today + 6.days
      expect(Delivery.next(today).to_date).to eq expected.to_date
    end
  end
end

describe Delivery, '#range' do
  context 'when Today is Friday' do
    let(:today) { Time.now.next_week(:friday) }
    it 'ranges from Today to last Friday' do
      expect(Delivery.range(today)).to cover(today - 7.days)
      expect(Delivery.range(today)).to cover(today)
    end

    it 'does not include Tomorrow' do
      expect(Delivery.range(today)).not_to cover(today + 1.day)
    end

    it 'does not include last Thursday' do
      expect(Delivery.range(today)).not_to cover(today - 8.days)
    end
  end

  context 'when Today is Thursday' do
    let(:today) { Time.now.next_week(:thursday) }
    it 'ranges from Tomorrow to last Friday' do
      expect(Delivery.range(today)).to cover(today + 1.day)
      expect(Delivery.range(today)).to cover(today - 6.days)
    end

    it 'does not include this Saturday' do
      expect(Delivery.range(today)).not_to cover(today + 2.days)
    end

    it 'does not include last Thursday' do
      expect(Delivery.range(today)).not_to cover(today - 7.days)
    end
  end

  context 'when Today is Saturday' do
    let(:today) { Time.now.next_week(:saturday) }
    it 'ranges from Yesterday to next Friday' do
      expect(Delivery.range(today)).to cover(today - 1.day)
      expect(Delivery.range(today)).to cover(today + 6.days)
    end

    it 'does not include last Thursday' do
      expect(Delivery.range(today)).not_to cover(today - 2.days)
    end

    it 'does not include next Saturday' do
      expect(Delivery.range(today)).not_to cover(today + 7.days)
    end
  end
end

describe Delivery, '#cutoff' do
  it 'is a Wednesday' do
    expect(Delivery.cutoff).to be_wednesday
  end

  context 'when Today is Wednesday' do
    let(:today) { Time.now.next_week(:wednesday) }

    it 'cutoff is Today' do
      expect(Delivery.cutoff(today)).to eq today.end_of_day
    end
  end

  context 'when Today is Tuesday' do
    let(:today) { Time.now.next_week(:tuesday) }

    it 'cutoff is Tomorrow' do
      expected = today + 1.day
      expect(Delivery.cutoff(today)).to eq expected.end_of_day
    end
  end

  context 'when Today is Thursday' do
    let(:today) { Time.now.next_week(:thursday) }

    it 'cutoff is next Thursday' do
      expected = today + 6.days
      expect(Delivery.cutoff(today)).to eq expected.end_of_day
    end
  end
end