# frozen_string_literal: true

RSpec.describe Mutation::Runner do
  describe '.call' do
    let(:condition_variable) { class_double(ConditionVariable)                 }
    let(:delay)              { instance_double(Float)                          }
    let(:driver)             { instance_double(Mutation::Parallel::Driver)       }
    let(:env_result)         { instance_double(Mutation::Result::Env)            }
    let(:kernel)             { class_double(Kernel)                            }
    let(:mutex)              { class_double(Mutex)                             }
    let(:processor)          { instance_double(Method)                         }
    let(:reporter)           { instance_double(Mutation::Reporter, delay: delay) }
    let(:thread)             { class_double(Thread)                            }

    let(:env) do
      instance_double(
        Mutation::Env,
        config:    config,
        mutations: []
      )
    end

    let(:config) do
      instance_double(
        Mutation::Config,
        condition_variable: condition_variable,
        jobs:               1,
        kernel:             kernel,
        mutex:              mutex,
        reporter:           reporter,
        thread:             thread
      )
    end

    let(:status_a) do
      instance_double(
        Mutation::Parallel::Status,
        done?: false
      )
    end

    let(:status_b) do
      instance_double(
        Mutation::Parallel::Status,
        done?:   true,
        payload: env_result
      )
    end

    let(:parallel_config) do
      Mutation::Parallel::Config.new(
        condition_variable: condition_variable,
        jobs:               1,
        mutex:              mutex,
        processor:          processor,
        sink:               Mutation::Runner::Sink.new(env),
        source:             Mutation::Parallel::Source::Array.new(env.mutations),
        thread:             thread
      )
    end

    def apply
      described_class.call(env)
    end

    let(:raw_expectations) do
      [
        {
          receiver:  reporter,
          selector:  :start,
          arguments: [env]
        },
        {
          receiver:  env,
          selector:  :method,
          arguments: [:kill],
          reaction:  { return: processor }
        },
        {
          receiver:  Mutation::Parallel,
          selector:  :async,
          arguments: [parallel_config],
          reaction:  { return: driver }
        },
        {
          receiver:  driver,
          selector:  :wait_timeout,
          arguments: [delay],
          reaction:  { return: status_a }
        },
        {
          receiver:  reporter,
          selector:  :progress,
          arguments: [status_a]
        },
        {
          receiver:  driver,
          selector:  :wait_timeout,
          arguments: [delay],
          reaction:  { return: status_b }
        },
        {
          receiver:  reporter,
          selector:  :report,
          arguments: [env_result]
        }
      ]
    end

    it 'returns env result' do
      verify_events { expect(apply).to eql(env_result) }
    end
  end
end
