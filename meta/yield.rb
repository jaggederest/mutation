# frozen_string_literal: true

Mutation::Meta::Example.add :yield do
  source 'yield true'

  singleton_mutations
  mutation 'yield false'
  mutation 'yield nil'
  mutation 'yield'
end
