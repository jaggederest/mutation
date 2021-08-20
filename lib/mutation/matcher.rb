# frozen_string_literal: true

module Mutation
  # Abstract matcher to find subjects to mutate
  class Matcher
    include Adamantium::Flat, AbstractType

    # Call matcher
    #
    # @param [Env::Bootstrap] env
    #
    # @return [Enumerable<Subject>]
    #
    abstract_method :call

  end # Matcher
end # Mutation
