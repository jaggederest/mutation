# frozen_string_literal: true

Mutation::Meta::Example.add :regexp_bos_anchor do
  source '/\A/'

  singleton_mutations
  regexp_mutations
end

Mutation::Meta::Example.add :regexp_bos_anchor do
  source '/^#{a}/'

  singleton_mutations
  regexp_mutations

  mutation '/^#{nil}/'
  mutation '/^#{self}/'
end
