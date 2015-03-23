require 'spec_helper'

shared_examples_for Measureable do

  let!(:relation) do
    described_class.to_s.split(/portion/i).first.downcase.to_sym
  end

  it { should belong_to(:ingredient) }
  it { should validate_presence_of(:ingredient) }

  it { should belong_to(relation) }
  it { should validate_presence_of(relation) }

  %i(quantity ingredient unit pantry? name category photo).each do |method|
    it { should respond_to(method) }
  end

  describe described_class, "#convert_tsp" do
    context "with different quantities" do
      it "converts to the correct unit based on tsp quantity" do
        subject.quantity = (3.0 / 4.0) # 1 tbsp
        expect(subject.convert_tsp(4)).to eq "1 tbsp"

        subject.quantity = (6.0 / 4.0) # 2 tbsp
        expect(subject.convert_tsp(4)).to eq "2 tbsps"

        subject.quantity = (5.0 / 4.0)
        expect(subject.convert_tsp(4)).to eq "1 & 2/3 tbsps"

        # increase the servings
        subject.quantity = (20.0 / 4.0)
        expect(subject.convert_tsp(30)).to eq "3 & 1/8 cups"
      end
    end
  end

  describe described_class, "#convert_ozs" do
    context "with different quantities" do
      it "converts to lbs based on oz quantity" do
        subject.quantity = (48.0 / 4.0) # 3 lbs.
        expect(subject.convert_oz(4)).to eq "3 lbs"

        subject.quantity = (24.0 / 4.0) # 3 lbs.
        expect(subject.convert_oz(4)).to eq "1 & 1/2 lbs"
      end
    end
  end

  describe described_class, "#to_display_amount" do
    context "with a saved unit" do
      it "should automatically use the correct units" do
        subject.quantity = (16.0 / 4.0)
        subject.stub(:unit).and_return('tsp')
        expect(subject.to_display_amount(4)).to eq "5 & 1/3 tbsps"

        subject.stub(:unit).and_return('oz')
        expect(subject.to_display_amount(4)).to eq "1 lb"

        subject.stub(:unit).and_return('unit')
        expect(subject.to_display_amount(4)).to eq "16"
      end
    end
  end

  describe described_class, "#determine_quantity" do
    context "with a saved unit" do
      it "should automatically determine the total quantity" do
        quantity = (16.0 / 4.0)
        subject.stub(:measurement_type).and_return('liquid')
        subject.stub(:unit).and_return('tsp')
        expect(subject.determine_quantity("tbsp", quantity)).to eq 12

        subject.stub(:measurement_type).and_return('liquid')
        subject.stub(:unit).and_return('tbsp')
        expect(subject.determine_quantity("tbsp", quantity)).to eq 4

        subject.stub(:measurement_type).and_return('solid')
        subject.stub(:unit).and_return('oz')
        expect(subject.determine_quantity("lb", quantity)).to eq 64

        subject.stub(:measurement_type).and_return('solid')
        subject.stub(:unit).and_return('unit')
        expect(subject.determine_quantity("lb", quantity)).to eq 4
      end
    end
  end

end
