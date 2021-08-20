# frozen_string_literal: true

Mutation::Meta::Example.add :return do
  source 'return'

  singleton_mutations
end

Mutation::Meta::Example.add :return do
  source 'return foo'

  singleton_mutations
  mutation 'foo'
  mutation 'return nil'
  mutation 'return self'
end
