# frozen_string_literal: true

Mutation::Meta::Example.add :nth_ref do
  source '$1'

  mutation '$2'
end

Mutation::Meta::Example.add :nth_ref do
  source '$3'

  mutation '$2'
  mutation '$4'
end
