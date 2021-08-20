# frozen_string_literal: true

module Mutation
  # Standalone configuration of a mutation execution.
  #
  # Does not reference any "external" volatile state. The configuration applied
  # to current environment is being represented by the Mutation::Env object.
  class Config
    include Adamantium::Flat, Anima.new(
      :condition_variable,
      :expression_parser,
      :fail_fast,
      :includes,
      :integration,
      :isolation,
      :jobs,
      :kernel,
      :load_path,
      :matcher,
      :mutex,
      :open3,
      :pathname,
      :reporter,
      :requires,
      :thread,
      :zombie
    )

    %i[fail_fast zombie].each do |name|
      define_method(:"#{name}?") { public_send(name) }
    end

  end # Config
end # Mutation
