# frozen_string_literal: true

RSpec.describe 'minitest integration', mutation: false do
  let(:base_cmd) do
    %w[bundle exec mutation -I test -I lib --require test_app --use minitest]
  end

  let(:gemfile) { 'Gemfile.minitest' }

  it_behaves_like 'framework integration'
end
