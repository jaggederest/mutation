# frozen_string_literal: true

module Mutation
  class Mutator
    class Node
      class Literal
        # Mutator for string literals
        class String < self

          handle(:str)

        private

          # Emit mutations
          #
          # @return [undefined]
          def dispatch
            emit_singletons
          end

        end # String
      end # Literal
    end # Node
  end # Mutator
end # Mutation
