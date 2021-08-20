# frozen_string_literal: true

RSpec.describe Mutation::Expression::Parser do
  let(:object) { Mutation::Config::DEFAULT.expression_parser }

  describe '#call' do
    subject { object.call(input) }

    context 'on nonsense' do
      let(:input) { 'foo bar' }

      it 'raises an exception' do
        expect { subject }.to raise_error(
          Mutation::Expression::Parser::InvalidExpressionError,
          'Expression: "foo bar" is not valid'
        )
      end
    end

    context 'on a valid expression' do
      let(:input) { 'Foo' }

      it { should eql(Mutation::Expression::Namespace::Exact.new(scope_name: 'Foo')) }
    end
  end

  describe '.try_parse' do
    subject { object.try_parse(input) }

    context 'on nonsense' do
      let(:input) { 'foo bar' }

      it { should be(nil) }
    end

    context 'on a valid expression' do
      let(:input) { 'Foo' }

      it { should eql(Mutation::Expression::Namespace::Exact.new(scope_name: 'Foo')) }
    end

    context 'on ambiguous expression' do
      let(:object) { described_class.new([test_a, test_b]) }

      let(:test_a) do
        Class.new(Mutation::Expression) do
          include Anima.new
          const_set(:REGEXP, /\Atest-syntax\z/.freeze)
        end
      end

      let(:test_b) do
        Class.new(Mutation::Expression) do
          include Anima.new
          const_set(:REGEXP, /^test-syntax$/.freeze)
        end
      end

      let(:input) { 'test-syntax' }

      it 'raises expected exception' do
        expect { subject }.to raise_error(
          Mutation::Expression::Parser::AmbiguousExpressionError,
          'Ambiguous expression: "test-syntax"'
        )
      end
    end
  end
end
