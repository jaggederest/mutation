# frozen_string_literal: true

RSpec.describe Mutation::Reporter::CLI::Printer::MutationProgressResult do
  setup_shared_context

  let(:reportable) { mutation_a_result }

  before do
    allow(output).to receive(:tty?).and_return(true)
  end

  describe '.run' do
    context 'on killed mutation' do
      with(:mutation_a_test_result) { { passed: true } }

      it_reports Mutation::Color::RED.format('F')
    end

    context 'on alive mutation' do
      with(:mutation_a_test_result) { { passed: false } }

      it_reports Mutation::Color::GREEN.format('.')
    end
  end
end
