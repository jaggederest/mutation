# frozen_string_literal: true

Mutation::Meta::Example.add :ivasgn do
  source '@a = true'

  singleton_mutations
  mutation '@a__mutation__ = true'
  mutation '@a = false'
  mutation '@a = nil'
end

Mutation::Meta::Example.add :ivasgn do
  source '@a &&= 1'

  singleton_mutations

  mutation '@a__mutation__ &&= 1'
  mutation '@a &&= nil'
  mutation '@a &&= 0'
  mutation '@a &&= -1'
  mutation '@a &&= 2'
  mutation '@a &&= self'
end
