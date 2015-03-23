require 'spec_helper'

shared_examples_for Portionable do
  it_behaves_like Quantifiable

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

  %i(pantry not_pantry produce meats groceries). each do |scope|
    describe "::#{scope}" do
      it "joins the ingredient table and merges scopes" do
        expect(Ingredient).to receive(scope)
        expect(described_class).to receive(:joins).with(:ingredient).and_call_original

        described_class.send(scope)
      end
    end
  end

  describe described_class, "#to_fraction" do

    context "without a family_size" do
      it "displays any overflow" do
        subject.quantity = 4/3.0
        expect(subject.to_fraction).to eq("1 & 1/3")
      end

      it "displays whole numbers when possible" do
        subject.quantity = 4/2.0
        expect(subject.to_fraction).to eq("2")
      end

      it "omits overflow when there is none" do
        subject.quantity = 1/2.0
        expect(subject.to_fraction).to eq("1/2")
      end
    end

    context "with a family_size" do
      it "displays any overflow" do
        subject.quantity = 4/3.0
        expect(subject.to_fraction(2)).to eq("2 & 2/3")
      end

      it "displays whole numbers when possible" do
        subject.quantity = 4/2.0
        expect(subject.to_fraction(2)).to eq("4")
      end

      it "omits overflow when there is none" do
        subject.quantity = 1/2.0
        expect(subject.to_fraction(3)).to eq("1 & 1/2")
      end
    end
  end


  describe described_class, "#to_display_amount"
    context "where ingredient has unit = 'tsp'" do
      it "converts to the correct unit based on tsp quantity" do
        subject.quantity = 768
        expect(subject.to_display_amount(1, "tsp")).to eq "1 gallon"

        subject.quantity = 192
        expect(subject.to_display_amount(1, "tsp")).to eq "1 quart"

        subject.quantity = 96
        expect(subject.to_display_amount(1, "tsp")).to eq "1 pint"

        subject.quantity = 48
        expect(subject.to_display_amount(1, "tsp")).to eq "1 cup"

        subject.quantity = 6
        expect(subject.to_display_amount(1, "tsp")).to eq "1 oz"

        subject.quantity = 3
        expect(subject.to_display_amount(1, "tsp")).to eq "1 tbsp"

        subject.quantity = 1
        expect(subject.to_display_amount(1, "tsp")).to eq "1 tsp"

        
        subject.quantity = 777
        expect(subject.to_display_amount(1, "tsp")).to eq "1 gallon"

        subject.quantity = 200
        expect(subject.to_display_amount(1, "tsp")).to eq "1 quart"

        subject.quantity = 100
        expect(subject.to_display_amount(1, "tsp")).to eq "1 pint"

        subject.quantity = 54
        expect(subject.to_display_amount(1, "tsp")).to eq "1 & 1/8 cups"



        subject.quantity = 7
        expect(subject.to_display_amount(1, "tsp")).to eq "1 & 1/6 ozs"

        subject.quantity = 4
        expect(subject.to_display_amount(1, "tsp")).to eq "1 & 1/3 tbsps"

        subject.quantity = 2
        expect(subject.to_display_amount(1, "tsp")).to eq "2 tsps"


        subject.quantity = 0
        expect(subject.to_display_amount(1, "tsp")).to eq "-"

        subject.quantity = 1/4
        expect(subject.to_display_amount(1, "tsp")).to eq "to taste"

        subject.quantity = 1
        expect(subject.to_display_amount(1, "tsp")).not_to eq "to taste"
      end
    end
    
    context "where ingredient has unit = 'oz'" do
      it "converts to the correct unit based on oz quantity" do
        subject.quantity = 1000
        expect(subject.to_display_amount(1, "oz")).to eq "62 & 1/2 lbs"

        subject.quantity = 17
        expect(subject.to_display_amount(1, "oz")).to eq "1 lb"

        subject.quantity = 16
        expect(subject.to_display_amount(1, "oz")).to eq "1 lb"

        subject.quantity = 15
        expect(subject.to_display_amount(1, "oz")).to eq "15 ozs"

        subject.quantity = 1
        expect(subject.to_display_amount(1, "oz")).to eq "1 oz"
      end
    end
    
    context "where ingredient has unit = 'unit'" do
      it "converts to the correct unit based on oz quantity" do
        subject.quantity = 1000
        expect(subject.to_display_amount(1, "unit")).to eq "1000"

        subject.quantity = 1.5
        expect(subject.to_display_amount(1, "unit")).to eq "1 & 1/2"

        subject.quantity = 1.75
        expect(subject.to_display_amount(1, "unit")).to eq "1 & 3/4"

        subject.quantity = 1
        expect(subject.to_display_amount(1, "unit")).to eq "1"

        subject.quantity = 1/12
        expect(subject.to_display_amount(1, "unit")).to eq "a small portion"
      end
    end
  end
