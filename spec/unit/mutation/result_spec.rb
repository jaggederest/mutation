# frozen_string_literal: true

RSpec.describe Mutation::Result do
  let(:object) do
    Class.new do
      include Mutation::Result, Concord.new(:runtime, :killtime)

      def collection
        [[1]]
      end

      sum :length, :collection
    end.new(3.0, 1.0)
  end

  describe '.included' do
    it 'includes mixin to freeze instances' do
      expect(object.frozen?).to be(true)
    end

    it 'it makes DSL methods from Mutation::Result available' do
      expect(object.length).to be(1)
    end
  end

  describe '#overhead' do
    subject { object.overhead }

    it 'returns difference between runtime and killtime' do
      should eql(2.0)
    end
  end
end
