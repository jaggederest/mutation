# frozen_string_literal: true

Mutation::Meta::Example.add :lvasgn do
  source 'a = true'

  singleton_mutations
  mutation 'a__mutation__ = true'
  mutation 'a = false'
  mutation 'a = nil'
end

Mutation::Meta::Example.add :array, :lvasgn do
  source 'a = *b'

  singleton_mutations
  mutation 'a__mutation__ = *b'
  mutation 'a = nil'
  mutation 'a = self'
  mutation 'a = []'
  mutation 'a = [nil]'
  mutation 'a = [self]'
  mutation 'a = [*self]'
  mutation 'a = [*nil]'
  mutation 'a = [b]'
end
