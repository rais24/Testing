require 'spec_helper'

shared_examples_for Slugged do
  it { should validate_uniqueness_of(:slug) }

  describe "#to_param" do
    it "returns the slug" do
      expect(subject.to_param).to eq(subject.slug)
    end
  end

  describe "#generate_slug" do
    it "slugifies the name" do
      expect(subject.generate_slug).to eq(subject.name.parameterize)
    end
  end

  describe "::find_by_id_or_slug!" do
    context "when passed junk" do
      it "raises ActiveRecord::RecordNotFound" do
        expect{described_class.find_by_id_or_slug!("junk")}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when called with a numeric" do
      it "finds by id" do
        expect(described_class.find_by_id_or_slug!(subject.id)).to eq(subject)
      end
    end

    context "when called with a string" do
      it "finds by slug" do
        expect(described_class.find_by_id_or_slug!(subject.name.parameterize)).to eq(subject)
      end
    end
  end
end