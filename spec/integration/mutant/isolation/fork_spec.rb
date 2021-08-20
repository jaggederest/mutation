# frozen_string_literal: true

RSpec.describe Mutation::Isolation::Fork, mutation: false do
  # rubocop:disable Lint/AmbiguousBlockAssociation
  specify do
    a = 1
    expect do
      Mutation::Config::DEFAULT.isolation.call { a = 2 }
    end.to_not change { a }
  end
end
