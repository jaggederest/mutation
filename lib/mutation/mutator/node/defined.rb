# frozen_string_literal: true

module Mutation
  class Mutator
    class Node
      # Namespace for `defined?` mutations
      class Defined < self

        handle(:defined?)

        children :expression

      private

        # Emit mutations
        #
        # @return [undefined]
        def dispatch
          emit_singletons
          emit(N_TRUE)

          emit_expression_mutations { |node| !n_self?(node) }
        end

      end # Defined
    end # Node
  end # Mutator
end # Mutation
