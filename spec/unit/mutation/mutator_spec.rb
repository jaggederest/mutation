# frozen_string_literal: true

RSpec.describe Mutation::Mutator do
  describe '.handle' do
    subject do
      Class.new(described_class) do
        const_set(:REGISTRY, Mutation::Registry.new)

        handle :send

        def dispatch
          emit(parent)
        end
      end
    end

    it 'should register mutator' do
      expect(subject.mutate(s(:send), s(:parent))).to eql([s(:parent)].to_set)
    end
  end
end
