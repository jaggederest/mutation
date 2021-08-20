# frozen_string_literal: true

RSpec.describe Mutation::Matcher::Null, '#call' do
  let(:object) { described_class.new          }
  let(:env)    { instance_double(Mutation::Env) }

  subject { object.call(env) }

  it 'returns no subjects' do
    should eql([])
  end
end
