# frozen_string_literal: true

require File.expand_path('lib/mutation/version', __dir__)

Gem::Specification.new do |gem|
  gem.name        = 'mutation-minitest'
  gem.version     = Mutation::VERSION.dup
  gem.authors     = ['Markus Schirp', 'Justin George']
  gem.email       = %w[justin.george@gmail.com]
  gem.description = 'Minitest integration for Mutation'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/jaggederest/mutation/'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files -- lib/mutation/{minitest,/integration/minitest.rb}`.split("\n")
  gem.test_files       = `git ls-files -- spec/integration/mutation/minitest.rb`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE]

  gem.add_runtime_dependency('minitest', '~> 5.11')
  gem.add_runtime_dependency('mutation',   "~> #{gem.version}")
end
