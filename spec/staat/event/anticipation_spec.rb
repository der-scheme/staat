require 'spec_helper'

describe Staat::Event::Anticipation do
  describe '.new' do
    context 'when everything is in order' do
      it 'should return properly' do
        expect(Staat::Event::Anticipation.new(name: 'test', scope: Object, action: :commit, type: :invocation) {})
            .to be_a(Staat::Event::Anticipation)

        expect(Staat::Event::Anticipation.new(scope: Object, action: :bail_out, type: :failure) {})
            .to be_a(Staat::Event::Anticipation)

        expect(Staat::Event::Anticipation.new(name: nil, scope: Object, action: :init, type: :completion) {})
            .to be_a(Staat::Event::Anticipation)
      end
    end

    context 'with invalid scope' do
      it 'should fail' do
        expect {Staat::Event::Anticipation.new(scope: :foo)}
            .to raise_error(TypeError, 'expected scope to be Class or Module')

        expect {Staat::Event::Anticipation.new(scope: 'bar')}
            .to raise_error(TypeError, 'expected scope to be Class or Module')

        expect {Staat::Event::Anticipation.new(name: 'test', scope: false, action: :commit, type: :failure) {}}
            .to raise_error(TypeError, 'expected scope to be Class or Module')
      end
    end

    context 'when called without block' do
      it 'should fail' do
        expect {Staat::Event::Anticipation.new(name: 'test', scope: Object, action: :commit, type: :failure)}
            .to raise_error(ArgumentError, 'expected a block to be given')
      end
    end
  end

  describe '#to_query' do
    let(:a1) {Staat::Event::Anticipation.new(name: 'test', scope: Object, action: :commit, type: :invocation) {}}
    let(:a2) {Staat::Event::Anticipation.new(scope: Object, action: :bail_out, type: :failure) {}}
    let(:a3) {Staat::Event::Anticipation.new(name: nil, scope: Object, action: :init, type: :completion) {}}

    it 'should return a Hash containing all the params to .new' do
      expect(a1.to_query).to eq({name: 'test', scope: Object, action: :commit, type: :invocation})
      expect(a2.to_query).to eq({name: nil, scope: Object, action: :bail_out, type: :failure})
      expect(a3.to_query).to eq({name: nil, scope: Object, action: :init, type: :completion})
    end
  end
end
