# frozen_string_literal: true

Mutation::Meta::Example.add :true do
  source 'true'

  mutation 'nil'
  mutation 'false'
end
