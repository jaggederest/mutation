# frozen_string_literal: true

Mutation::Meta::Example.add :ivar do
  source '@foo'

  singleton_mutations
  mutation 'foo'
end
