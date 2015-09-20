require 'spec_helper'

describe Staat::Event::Manager do
  describe '#<<' do
    it 'should return self' do
    end

    it 'should store with respect to scope, action, type and name' do
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
