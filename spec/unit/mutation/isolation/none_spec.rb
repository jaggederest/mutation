# frozen_string_literal: true

RSpec.describe Mutation::Isolation::None do
  describe '.call' do
    let(:object) { described_class.new }

    context 'without exception' do
      it 'returns success result' do
        expect(object.call { :foo })
          .to eql(Mutation::Isolation::Result::Success.new(:foo))
      end
    end

    context 'with exception' do
      let(:exception) { RuntimeError.new('foo') }

      it 'returns error result' do
        expect(object.call { fail exception })
          .to eql(Mutation::Isolation::Result::Exception.new(exception))
      end
    end
  end
end
