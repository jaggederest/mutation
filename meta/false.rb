# frozen_string_literal: true

Mutation::Meta::Example.add :false do
  source 'false'

  mutation 'nil'
  mutation 'true'
end
