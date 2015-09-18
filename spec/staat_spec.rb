require 'spec_helper'

describe Staat do
  it 'is a Module' do
    expect(Staat.class).to be Module
  end

  it 'has a version number' do
    expect(Staat::VERSION).not_to be nil
  end
end
