# frozen_string_literal: true

Mutation::Meta::Example.add :sym do
  source ':foo'

  singleton_mutations
  mutation ':foo__mutation__'
end
