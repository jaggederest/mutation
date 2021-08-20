# frozen_string_literal: true

Mutation::Meta::Example.add :cbase do
  source '::A'

  singleton_mutations
  mutation 'A'
end
