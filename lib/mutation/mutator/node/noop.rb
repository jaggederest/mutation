# frozen_string_literal: true

module Mutation
  class Mutator
    class Node

      # Mutation emitter to handle noop nodes
      class Noop < self

        handle(:__ENCODING__, :block_pass, :cbase, :lambda)

      private

        # Emit mutations
        #
        # @return [undefined]
        def dispatch
          # noop
        end

      end # Noop
    end # Node
  end # Mutator
end # Mutation
