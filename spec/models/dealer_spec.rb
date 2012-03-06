require 'spec_helper'

describe Dealer do
  it { should validate_presence_of :name }
  it { should validate_presence_of :logo }
end
