# frozen_string_literal: true

Mutation::Meta::Example.add :super do
  source 'super'

  singleton_mutations
  mutation 'super()'
end

Mutation::Meta::Example.add :super do
  source 'super()'

  singleton_mutations
end

Mutation::Meta::Example.add :super do
  source 'super(foo, bar)'

  singleton_mutations
  mutation 'super()'
  mutation 'super(foo)'
  mutation 'super(bar)'
  mutation 'super(foo, nil)'
  mutation 'super(foo, self)'
  mutation 'super(nil, bar)'
  mutation 'super(self, bar)'
end
