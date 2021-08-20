# frozen_string_literal: true

RSpec.describe Mutation::Matcher::Chain, '#call' do
  subject { object.call(env) }

  let(:object)    { described_class.new([matcher_a, matcher_b]) }
  let(:env)       { instance_double(Mutation::Env)                }
  let(:matcher_a) { instance_double(Mutation::Matcher)            }
  let(:matcher_b) { instance_double(Mutation::Matcher)            }
  let(:subject_a) { instance_double(Mutation::Subject)            }
  let(:subject_b) { instance_double(Mutation::Subject)            }

  before do
    expect(matcher_a).to receive(:call)
      .with(env)
      .and_return([subject_a])

    expect(matcher_b).to receive(:call)
      .with(env)
      .and_return([subject_b])
  end

  it 'returns concatenated matches' do
    should eql([subject_a, subject_b])
  end
end
