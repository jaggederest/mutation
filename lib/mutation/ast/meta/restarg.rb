# frozen_string_literal: true

module Mutation
  module AST
    # Node meta information mixin
    module Meta

      # Metadata for restarg nodes
      class Restarg
        include NamedChildren, Concord.new(:node)

        children :name

        public :name
      end # Restarg

    end # Meta
  end # AST
end # Mutation
