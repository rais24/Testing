require 'spec_helper'

shared_examples_for Zippable do
  ["H2L 3K5", "12345", "12345-1234"].each do |valid|
    it { should allow_value(valid).for(:zipcode) }
  end


  [nil, "", "123456"].each do |invalid|
    it { should_not allow_value(invalid).for(:zipcode) }
  end
end