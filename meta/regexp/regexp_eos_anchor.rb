# frozen_string_literal: true

Mutation::Meta::Example.add :regexp_eos_anchor do
  source '/\z/'

  singleton_mutations
  regexp_mutations
end
