# frozen_string_literal: true

Mutation::Meta::Example.add :const do
  source 'A::B::C'

  singleton_mutations
  mutation 'B::C'
  mutation 'C'
end

Mutation::Meta::Example.add :const do
  source 'A.foo'

  singleton_mutations
  mutation 'A'
  mutation 'self.foo'
end
