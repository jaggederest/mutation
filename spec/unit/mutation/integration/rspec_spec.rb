# frozen_string_literal: true

require 'mutation/integration/rspec'

RSpec.describe Mutation::Integration::Rspec do
  let(:object) { described_class.new(Mutation::Config::DEFAULT) }

  let(:rspec_options) { instance_double(RSpec::Core::ConfigurationOptions) }
  let(:rspec_runner)  { instance_double(RSpec::Core::Runner)               }

  let(:example_a) do
    double(
      'Example A',
      metadata: {
        location:         'example-a-location',
        full_description: 'example-a-full-description'
      }
    )
  end

  let(:example_b) do
    double(
      'Example B',
      metadata: {
        location:         'example-b-location',
        full_description: 'example-b-full-description',
        mutation:           false
      }
    )
  end

  let(:example_c) do
    double(
      'Example C',
      metadata: {
        location:         'example-c-location',
        full_description: 'Example::C blah'
      }
    )
  end

  let(:example_d) do
    double(
      'Example D',
      metadata: {
        location:         'example-d-location',
        full_description: "Example::D\nblah"
      }
    )
  end

  let(:example_e) do
    double(
      'Example E',
      metadata: {
        location:          'example-e-location',
        full_description:  'Example::E',
        mutation_expression: 'Foo'
      }
    )
  end

  let(:examples) do
    [
      example_a,
      example_b,
      example_c,
      example_d,
      example_e
    ]
  end

  let(:example_groups) do
    [
      double(
        'root example group',
        descendants: [
          double('example group', examples: examples)
        ]
      )
    ]
  end

  let(:filtered_examples) do
    {
      double('Key') => examples.dup
    }
  end

  let(:world) do
    double(
      'world',
      example_groups:    example_groups,
      filtered_examples: filtered_examples
    )
  end

  let(:all_tests) do
    [
      Mutation::Test.new(
        id:         'rspec:0:example-a-location/example-a-full-description',
        expression: parse_expression('*')
      ),
      Mutation::Test.new(
        id:         'rspec:1:example-c-location/Example::C blah',
        expression: parse_expression('Example::C')
      ),
      Mutation::Test.new(
        id:         "rspec:2:example-d-location/Example::D\nblah",
        expression: parse_expression('*')
      ),
      Mutation::Test.new(
        id:         'rspec:3:example-e-location/Example::E',
        expression: parse_expression('Foo')
      )
    ]
  end

  before do
    expect(RSpec::Core::ConfigurationOptions).to receive(:new)
      .with(%w[spec --fail-fast])
      .and_return(rspec_options)

    expect(RSpec::Core::Runner).to receive(:new)
      .with(rspec_options)
      .and_return(rspec_runner)

    expect(RSpec).to receive_messages(world: world)
    allow(Mutation::Timer).to receive_messages(now: Mutation::Timer.now)
  end

  describe '#all_tests' do
    subject { object.all_tests }

    it { should eql(all_tests) }
  end

  describe '#setup' do
    subject { object.setup }

    before do
      expect(rspec_runner).to receive(:setup) do |error, output|
        expect(error).to be($stderr)
        output.write('foo')
      end
    end

    it { should be(object) }
  end

  describe '#call' do
    subject { object.call(tests) }

    before do
      expect(rspec_runner).to receive(:setup) do |_errors, output|
        output.write('the-test-output')
      end

      object.setup
    end

    let(:tests) { [all_tests.fetch(0)] }

    before do
      expect(world).to receive(:ordered_example_groups) do
        filtered_examples.values.flatten
      end
      expect(rspec_runner).to receive(:run_specs).with([example_a]).and_return(exit_status)
    end

    context 'on unsuccessful exit' do
      let(:exit_status) { 1 }

      it 'should return failed result' do
        expect(subject).to eql(
          Mutation::Result::Test.new(
            output:  'the-test-output',
            passed:  false,
            runtime: 0.0,
            tests:   tests
          )
        )
      end
    end

    context 'on successful exit' do
      let(:exit_status) { 0 }

      it 'should return passed result' do
        expect(subject).to eql(
          Mutation::Result::Test.new(
            output:  'the-test-output',
            passed:  true,
            runtime: 0.0,
            tests:   tests
          )
        )
      end
    end
  end
end
