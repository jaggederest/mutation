# frozen_string_literal: true

module Mutation
  class Mutator
    class Node

      # Mutator for begin nodes
      class Begin < self

        handle(:begin)

      private

        # Emit mutations
        #
        # @return [undefined]
        def dispatch
          mutate_single_child do |child|
            emit(child)
          end
        end
      end # Begin
    end # Node
  end # Mutator
end # Mutation
