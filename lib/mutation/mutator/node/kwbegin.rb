# frozen_string_literal: true

module Mutation
  class Mutator
    class Node

      # Kwbegin mutator
      class Kwbegin < Generic

        handle(:kwbegin)

      private

        # Emit mutations
        #
        # @return [undefined]
        def dispatch
          super()
          emit_singletons
        end

      end # Kwbegin
    end # Node
  end # Mutator
end # Mutation
