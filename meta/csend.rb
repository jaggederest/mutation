# frozen_string_literal: true

Mutation::Meta::Example.add :csend do
  source 'a&.b'

  singleton_mutations
  mutation 'a.b'
  mutation 'self&.b'
  mutation 'a'
end
