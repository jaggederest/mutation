# frozen_string_literal: true

module Mutation

  # Abstract base class mutation test framework integrations
  class Integration
    include AbstractType, Adamantium::Flat, Concord.new(:config)

    # Setup integration
    #
    # Integrations are supposed to define a constant under
    # Mutation::Integration named after the capitalized +name+
    # parameter.
    #
    # This avoids having to maintain a mutable registry.
    #
    # @param kernel [Kernel]
    # @param name [String]
    #
    # @return [Class<Integration>]
    def self.setup(kernel, name)
      kernel.require("mutation/integration/#{name}")
      const_get(name.capitalize)
    end

    # Perform integration setup
    #
    # @return [self]
    def setup
      self
    end

    # Run a collection of tests
    #
    # @param [Enumerable<Test>] tests
    #
    # @return [Result::Test]
    abstract_method :call

    # Available tests for integration
    #
    # @return [Enumerable<Test>]
    abstract_method :all_tests

  private

    # Expression parser
    #
    # @return [Expression::Parser]
    def expression_parser
      config.expression_parser
    end

    # Null integration that never kills a mutation
    class Null < self

      # Available tests for integration
      #
      # @return [Enumerable<Test>]
      def all_tests
        EMPTY_ARRAY
      end

      # Run a collection of tests
      #
      # @param [Enumerable<Mutation::Test>] tests
      #
      # @return [Result::Test]
      def call(tests)
        Result::Test.new(
          output:  '',
          passed:  true,
          runtime: 0.0,
          tests:   tests
        )
      end

    end # Null
  end # Integration
end # Mutation
