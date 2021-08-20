# frozen_string_literal: true

RSpec.describe 'Mutation on ruby corpus', mutation: false do
  MutationSpec::Corpus::Project::ALL.select(&:mutation_generation).each do |project|
    specify "#{project.name} does not fail on mutation generation" do
      project.verify_mutation_generation
    end
  end

  MutationSpec::Corpus::Project::ALL.select(&:mutation_coverage).each do |project|
    specify "#{project.name} (#{project.integration}) does have expected mutation coverage" do
      project.verify_mutation_coverage
    end
  end
end
