# frozen_string_literal: true

module Mutation
  class Mutator
    class Node

      # Dstr mutator
      class Dstr < Generic

        handle(:dstr)

      private

        # Emit mutations
        #
        # @return [undefined]
        def dispatch
          super()
          emit_singletons
        end

      end # Dstr
    end # Node
  end # Mutator
end # Mutation
