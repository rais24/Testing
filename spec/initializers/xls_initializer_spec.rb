require 'spec_helper'

describe Mime::XLS do
  its(:to_sym) { should eq :xls }
  its(:to_s) { should eq 'application/vnd.ms-excel; charset=utf-8;' }
end