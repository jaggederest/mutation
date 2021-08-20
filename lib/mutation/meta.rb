# frozen_string_literal: true

module Mutation
  # Namespace for mutation metadata
  module Meta
    require 'mutation/meta/example'
    require 'mutation/meta/example/dsl'
    require 'mutation/meta/example/verification'

    # Mutation example
    class Example

      # rubocop:disable MutableConstant
      ALL = []

      # Add example
      #
      # @return [undefined]
      #
      # rubocop:disable Performance/Caller
      def self.add(*types, &block)
        file = caller.first.split(':in', 2).first
        ALL << DSL.call(file, Set.new(types), block)
      end

      Pathname.glob(Pathname.new(__dir__).parent.parent.join('meta', '*.rb'))
        .sort
        .each(&method(:require))

      ALL.freeze

      # Remove mutation method only present for DSL executions from meta/**/*.rb
      class << self
        undef_method :add
      end

    end # Example
  end # Meta
end # Mutation
