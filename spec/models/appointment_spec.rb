require 'spec_helper'

describe Appointment do
  before do
    FactoryGirl.create :appointment
  end
  
  it { should validate_presence_of :date }
  it { should validate_presence_of :time }
  it { should validate_presence_of :status }
  it { should belong_to :customer }
end

describe Customer do
  it { should have_many :appointments }
end