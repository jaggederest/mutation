# frozen_string_literal: true

Mutation::Meta::Example.add :block, :lambda do
  source '->() {}'

  singleton_mutations

  mutation '->() { raise }'
end

Mutation::Meta::Example.add :block, :lambda do
  source '->() { foo.bar }'

  singleton_mutations

  mutation '->() { }'
  mutation '->() { self }'
  mutation '->() { nil }'
  mutation '->() { raise }'
  mutation '->() { self.bar }'
  mutation '->() { foo }'
  mutation 'foo.bar'
end
