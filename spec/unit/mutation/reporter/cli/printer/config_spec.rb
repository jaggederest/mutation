# frozen_string_literal: true

RSpec.describe Mutation::Reporter::CLI::Printer::Config do
  setup_shared_context

  let(:reportable) { config }

  describe '.call' do
    context 'on default config' do
      it_reports(<<~REPORT)
        Mutation configuration:
        Matcher:         #<Mutation::Matcher::Config empty>
        Integration:     Mutation::Integration::Null
        Jobs:            1
        Includes:        []
        Requires:        []
      REPORT
    end

    context 'with non default coverage expectation' do
      it_reports(<<~REPORT)
        Mutation configuration:
        Matcher:         #<Mutation::Matcher::Config empty>
        Integration:     Mutation::Integration::Null
        Jobs:            1
        Includes:        []
        Requires:        []
      REPORT
    end
  end
end
