# frozen_string_literal: true

Mutation::Meta::Example.add :str do
  source '"foo"'

  singleton_mutations
end
