require 'spec_helper'

describe Staat::Event::Manager do
  let(:a1) {Staat::Event::Anticipation.new(scope: BasicObject, action: :to_s, type: :all, name: :foo) {}}
  let(:a2) {Staat::Event::Anticipation.new(scope: Array, action: :each, type: :invocation) {}}
  let(:a3) {Staat::Event::Anticipation.new(scope: Hash, action: :each, type: :failure, name: :bar) {}}
  let(:a4) {Staat::Event::Anticipation.new(scope: BasicObject, action: :to_s, type: nil, name: :foo) {}}
  let(:a5) {Staat::Event::Anticipation.new(scope: String, action: :to_s, type: :completion, name: :baz) {}}
  let(:empty) {Staat::Event::Manager.new}
  let(:trivial) do
    Staat::Event::Manager.new << a1 << a3 << a5
  end
  let(:complex) do
    Staat::Event::Manager.new << a1 << a4 << a5 << a3 << a2
  end

  describe '#<<' do
    it 'should return self' do
      expect(empty << a1).to be(empty)
      expect(trivial << a2).to be(trivial)
      expect(complex << a3).to be(complex)
    end

    it 'should store with respect to scope, action, type and name' do
      expect(trivial[**a1.to_query]).to contain_exactly(a1)
      expect(trivial[**a2.to_query]).to be_nil
      expect(trivial[**a3.to_query]).to contain_exactly(a3)
      expect(trivial[**a4.to_query]).to contain_exactly(a1)
      expect(trivial[**a5.to_query]).to contain_exactly(a5)

      expect(complex[**a1.to_query]).to contain_exactly(a4)
      expect(complex[**a2.to_query]).to contain_exactly(a2)
      expect(complex[**a3.to_query]).to contain_exactly(a3)
      expect(complex[**a4.to_query]).to contain_exactly(a4)
      expect(complex[**a5.to_query]).to contain_exactly(a5)
    end

    it 'should also store in all superscopes of scope' do
    end

    context 'when type' do
      context 'is :all or nil' do
      end

      context 'is :invocation, :failure or :completion' do
      end
    end

    context 'when all selectors are identical to existing ones' do
      context 'and name is not nil' do
        it 'should overwrite matching objects' do
        end
      end

      context 'and name is nil' do
        it 'should not overwrite, but keep both new and old objects' do
        end
      end
    end
  end

  describe '#[]' do
    context "when parameters don't match any storeds" do
      it 'should return nil' do
      end
    end

    # moar

    context 'without parameters' do
      it 'should return all stored objects' do
      end
    end
  end

  describe '#clear' do
    it 'should remove all stored objects' do
    end
  end
end
