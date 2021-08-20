# frozen_string_literal: true

RSpec.describe Mutation::Matcher::Namespace, '#call' do
  let(:object)      { described_class.new(parse_expression('TestApp*')) }
  let(:env)         { instance_double(Mutation::Env)                      }
  let(:raw_scope_a) { instance_double(Class, name: 'TestApp::Literal')  }
  let(:raw_scope_b) { instance_double(Class, name: 'TestApp::Foo')      }
  let(:raw_scope_c) { instance_double(Class, name: 'TestAppOther')      }
  let(:subject_a)   { instance_double(Mutation::Subject)                  }
  let(:subject_b)   { instance_double(Mutation::Subject)                  }

  before do
    [
      [Mutation::Matcher::Methods::Singleton, raw_scope_b, [subject_b]],
      [Mutation::Matcher::Methods::Instance,  raw_scope_b, []],
      [Mutation::Matcher::Methods::Singleton, raw_scope_a, [subject_a]],
      [Mutation::Matcher::Methods::Instance,  raw_scope_a, []]
    ].each do |klass, scope, subjects|
      matcher = instance_double(Mutation::Matcher)
      expect(matcher).to receive(:call).with(env).and_return(subjects)

      expect(klass).to receive(:new)
        .with(scope)
        .and_return(matcher)
    end

    allow(env).to receive(:matchable_scopes).and_return(
      [raw_scope_a, raw_scope_b, raw_scope_c].map do |raw_scope|
        Mutation::Scope.new(raw_scope, parse_expression(raw_scope.name))
      end
    )
  end

  it 'returns subjects' do
    expect(object.call(env)).to eql([subject_a, subject_b])
  end
end
