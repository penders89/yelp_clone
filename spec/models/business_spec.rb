require 'spec_helper'

describe Business do 
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_numericality_of :price }
  it { is_expected.to have_many(:reviews).order('created_at desc') }
end