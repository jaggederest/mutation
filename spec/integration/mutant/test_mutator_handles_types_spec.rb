# frozen_string_literal: true

RSpec.describe 'AST type coverage', mutation: false do
  specify 'mutation should not crash for any node parser can generate' do
    Mutation::AST::Types::ALL.each do |type|
      Mutation::Mutator::REGISTRY.lookup(type)
    end
  end
end
