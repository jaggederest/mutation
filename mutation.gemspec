# frozen_string_literal: true

require File.expand_path('lib/mutation/version', __dir__)

Gem::Specification.new do |gem|
  gem.name        = 'mutation'
  gem.version     = Mutation::VERSION.dup
  gem.authors     = ['Markus Schirp', 'Justin George']
  gem.email       = ['justin.george@gmail.com']
  gem.description = 'Mutation testing for ruby'
  gem.summary     = 'Mutation testing tool for ruby under MRI and Rubinius'
  gem.homepage    = 'https://github.com/jaggederest/mutation'
  gem.license     = 'MIT'

  gem.require_paths = %w[lib]

  exclusion = `git ls-files -- lib/mutation/{minitest,integration}`.split("\n")

  gem.files            = `git ls-files`.split("\n") - exclusion
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE]
  gem.executables      = %w[mutation]

  gem.add_runtime_dependency('abstract_type', '~> 0.0.7')
  gem.add_runtime_dependency('adamantium',    '~> 0.2.0')
  gem.add_runtime_dependency('anima',         '~> 0.3.0')
  gem.add_runtime_dependency('ast',           '~> 2.2')
  gem.add_runtime_dependency('concord',       '~> 0.1.5')
  gem.add_runtime_dependency('diff-lcs',      '~> 1.3')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.9')
  gem.add_runtime_dependency('ice_nine',      '~> 0.11.1')
  gem.add_runtime_dependency('memoizable',    '~> 0.4.2')
  gem.add_runtime_dependency('morpher',       '>= 0.2.6')
  gem.add_runtime_dependency('parser',        '>= 2.5.1')
  gem.add_runtime_dependency('procto',        '~> 0.0.2')
  gem.add_runtime_dependency('regexp_parser', '>= 1.2')
  gem.add_runtime_dependency('unparser',      '~> 0.4.2')

  gem.add_development_dependency('devtools', '~> 0.1.23')
  gem.add_development_dependency('parallel', '~> 1.3')
end
