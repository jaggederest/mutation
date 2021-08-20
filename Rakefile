# frozen_string_literal: true

require 'devtools'

Devtools.init_rake_tasks

Rake.application.load_imports

task('metrics:mutation').clear
namespace :metrics do
  task mutation: :coverage do
    arguments = %w[
      bundle exec mutation
      --include lib
      --since HEAD~1
      --require mutation
      --use rspec
      --zombie
    ]
    arguments.concat(%w[--jobs 4]) if ENV.key?('CIRCLECI')

    arguments.concat(%w[-- Mutation*])

    Kernel.system(*arguments) or fail 'Mutation task is not successful'
  end
end
