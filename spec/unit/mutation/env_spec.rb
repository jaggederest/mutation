# frozen_string_literal: true

RSpec.describe Mutation::Env do
  let(:object) do
    described_class.new(
      config:           config,
      integration:      integration,
      matchable_scopes: [],
      mutations:        [],
      selector:         selector,
      subjects:         [mutation_subject],
      parser:           Mutation::Parser.new
    )
  end

  let(:integration)       { instance_double(Mutation::Integration) }
  let(:test_a)            { instance_double(Mutation::Test)        }
  let(:test_b)            { instance_double(Mutation::Test)        }
  let(:tests)             { [test_a, test_b]                     }
  let(:selector)          { instance_double(Mutation::Selector)    }
  let(:integration_class) { Mutation::Integration::Null            }
  let(:isolation)         { Mutation::Isolation::None.new          }
  let(:mutation_subject)  { instance_double(Mutation::Subject)     }

  let(:mutation) do
    instance_double(
      Mutation::Mutation,
      subject: mutation_subject
    )
  end

  let(:config) do
    Mutation::Config::DEFAULT.with(
      isolation:   isolation,
      integration: integration_class,
      kernel:      class_double(Kernel)
    )
  end

  before do
    allow(selector).to receive(:call)
      .with(mutation_subject)
      .and_return(tests)

    allow(Mutation::Timer).to receive(:now).and_return(2.0, 3.0)
  end

  describe '#kill' do
    subject { object.kill(mutation) }

    shared_examples_for 'mutation kill' do
      specify do
        should eql(
          Mutation::Result::Mutation.new(
            isolation_result: isolation_result,
            mutation:         mutation,
            runtime:          1.0
          )
        )
      end
    end

    context 'when isolation does not raise error' do
      let(:test_result) { instance_double(Mutation::Result::Test) }

      before do
        expect(mutation).to receive(:insert)
          .ordered
          .with(config.kernel)

        expect(integration).to receive(:call)
          .ordered
          .with(tests)
          .and_return(test_result)
      end

      let(:isolation_result) do
        Mutation::Isolation::Result::Success.new(test_result)
      end

      include_examples 'mutation kill'
    end

    context 'when code does raise error' do
      let(:exception) { RuntimeError.new('foo') }

      before do
        expect(mutation).to receive(:insert).and_raise(exception)
      end

      let(:isolation_result) do
        Mutation::Isolation::Result::Exception.new(exception)
      end

      include_examples 'mutation kill'
    end
  end

  describe '#selections' do
    subject { object.selections }

    it 'returns expected selections' do
      expect(subject).to eql(mutation_subject => tests)
    end
  end
end
