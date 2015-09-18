require 'spec_helper'

describe Staat::Event::Declaration do
  describe '.new' do
    context 'when everything is in order' do
      it 'should return properly' do
        expect(Staat::Event::Declaration.new(name: 'test', scope: Object, action: :commit, type: :invocation) {})
            .to be_a(Staat::Event::Declaration)

        expect(Staat::Event::Declaration.new(scope: Object, action: :bail_out, type: :failure) {})
            .to be_a(Staat::Event::Declaration)

        expect(Staat::Event::Declaration.new(name: nil, scope: Object, action: :init, type: :completion) {})
            .to be_a(Staat::Event::Declaration)
      end
    end

    context 'with invalid scope' do
      it 'should fail' do
        expect {Staat::Event::Declaration.new(scope: :foo)}
            .to raise_error(TypeError, 'expected scope to be Class or Module')

        expect {Staat::Event::Declaration.new(scope: 'bar')}
            .to raise_error(TypeError, 'expected scope to be Class or Module')

        expect {Staat::Event::Declaration.new(name: 'test', scope: false, action: :commit, type: :failure) {}}
            .to raise_error(TypeError, 'expected scope to be Class or Module')
      end
    end

    context 'when called without block' do
      it 'should fail' do
        expect {Staat::Event::Declaration.new(name: 'test', scope: Object, action: :commit, type: :failure)}
            .to raise_error(ArgumentError, 'expected a block to be given')
      end
    end
  end
end
