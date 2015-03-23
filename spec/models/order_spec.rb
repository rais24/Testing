require 'spec_helper'

describe Order do
  #it_behaves_like Purchaseable
  it_behaves_like HasSite
  
  it { should have_many(:portions) }
  it { should have_many(:servings) }

  it { should have_many(:ingredients).through(:portions) }
  it { should have_many(:recipes).through(:servings) }

  it { should belong_to(:user) }
  it { should have_one(:charge) }
  
  %w( guest placed
      week_of 
      for to deliverable
      paid checked_out pending
    ).each do |scope|
    it "should respond to ::#{scope} scope" do
      expect(described_class).to respond_to scope
    end
  end
end

describe Order, '#active?' do
  context 'before cutoff' do
    let(:now) { Delivery.cutoff - 1.day }

    it 'is active' do
      expect(subject.active?(now)).to be true
    end
  end

  context 'after cutoff' do
    let(:now) { Delivery.cutoff + 1.day }

    it 'is not active' do
      expect(subject.active?(now)).to be false
    end
  end
end

describe Order, '#can_checkout?' do
  context 'with less than 2 dinners' do
    it 'returns false' do
      order = create :order
      recipes = create_list :recipe, 2, meal: 'lunch'
      recipes.map do |r|
        create :order_serving, order: order, recipe: r
      end
      expect(order.can_checkout?).to be false
    end
  end

  context 'with 2 or more dinners' do
    it 'returns false' do
      order = create :order
      recipes = create_list :recipe, 2, meal: 'dinner'
      recipes.map do |r|
        create :order_serving, order: order, recipe: r
      end
      expect(order.can_checkout?).to be true
    end
  end
end

describe Order, '#calculate_price' do
  context 'with 2 dinners' do
    context 'with 4 servings per dinner' do
      it 'calculates price to be 63.92' do
        order = create :order
        recipes = create_list :recipe, 2, meal: 'dinner'
        recipes.map do |r|
          create :order_serving, order: order, recipe: r, quantity: 4
        end
        order.save!
        expect(order.price).to eq( 63.92 ) # 8 servings @ 7.99/serving
      end
    end
  end
  context 'with 3 dinners' do
    context 'with 4 servings per dinner' do
      it 'calculates price to 83.88' do
        order = create :order
        recipes = create_list :recipe, 3, meal: 'dinner'
        recipes.map do |r|
          create :order_serving, order: order, recipe: r, quantity: 4
        end
        order.save!
        expect(order.price).to eq( 83.88 ) # 12 servings @ 6.99/serving
      end
    end
  end
  context 'with 3 dinners' do
    context 'with 6 servings/dinner' do
      it 'calculates price to 41.94' do
        order = create :order
        # this is clunky, which screams refactor
        allow(order.user).to receive(:family_size) { 6 }
        recipes = create_list :recipe, 3, meal: 'dinner'
        recipes.map do |r|
          create :order_serving, order: order, recipe: r, quantity: 6
        end
        order.save!
        expect(order.price).to eq( 125.82 )
      end
    end
  end
  context 'with 5 or more dinners' do
    context 'with 4 servings/dinner' do
      it 'calculates price to 59.90' do
        order = create :order
        recipes = create_list :recipe, 5, meal: 'dinner'
        recipes.map do |r|
          create :order_serving, order: order, recipe: r, quantity: 4
        end
        order.save!
        expect(order.price).to eq( 119.80 )
      end
    end
  end
  context "with a promo code" do
    it "should only allow 1 promo code per user" do
      order = create :order
      promo = create :promo

      
      order.save!

    end
  end
end