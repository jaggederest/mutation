# frozen_string_literal: true

Mutation::Meta::Example.add :cvasgn do
  source '@@a = true'

  singleton_mutations
  mutation '@@a__mutation__ = true'
  mutation '@@a = false'
  mutation '@@a = nil'
end
