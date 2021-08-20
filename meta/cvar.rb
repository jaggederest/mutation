# frozen_string_literal: true

Mutation::Meta::Example.add :cvar do
  source '@@a'

  singleton_mutations
end
