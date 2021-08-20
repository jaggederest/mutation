# frozen_string_literal: true

Mutation::Meta::Example.add :gvar do
  source '$a'

  singleton_mutations
end
