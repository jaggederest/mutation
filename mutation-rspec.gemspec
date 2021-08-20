# frozen_string_literal: true

require File.expand_path('lib/mutation/version', __dir__)

Gem::Specification.new do |gem|
  gem.name        = 'mutation-rspec'
  gem.version     = Mutation::VERSION.dup
  gem.authors     = ['Markus Schirp', 'Justin George']
  gem.email       = ['justin.george@gmail.com']
  gem.description = 'Rspec integration for mutation'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/jaggederest/mutation'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files -- lib/mutation/integration/rspec.rb`.split("\n")
  gem.test_files       = `git ls-files -- spec/{integration,unit}/mutation/rspec_spec.rb}`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE]

  gem.add_runtime_dependency('mutation', "~> #{gem.version}")
  gem.add_runtime_dependency('rspec-core', '>= 3.4.0', '< 4.0.0')
end
