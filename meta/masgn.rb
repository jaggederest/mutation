# frozen_string_literal: true

Mutation::Meta::Example.add :masgn do
  source 'a, b = c, d'

  singleton_mutations
end
