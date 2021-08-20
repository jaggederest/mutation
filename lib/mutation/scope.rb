# frozen_string_literal: true

module Mutation
  # Class or Module bound to an exact expression
  class Scope
    include Concord::Public.new(:raw, :expression)
  end # Scope
end # Mutation
