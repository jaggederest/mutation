# frozen_string_literal: true

Mutation::Meta::Example.add :block_pass do
  source 'foo(&bar)'

  singleton_mutations
  mutation 'foo'
end
