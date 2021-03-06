# frozen_string_literal: true

Mutation::Meta::Example.add :kwarg do
  source 'def foo(bar:); end'

  mutation 'def foo; end'
  mutation 'def foo(bar:); raise; end'
  mutation 'def foo(bar:); super; end'
  mutation 'def foo(_bar:); end'
end
