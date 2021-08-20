# frozen_string_literal: true

RSpec.describe 'rspec integration', mutation: false do
  let(:base_cmd) do
    %w[bundle exec mutation -I lib --require test_app --use rspec]
  end

  %w[3.7 3.8].each do |version|
    context "RSpec #{version}" do
      let(:gemfile) { "Gemfile.rspec#{version}" }

      it_behaves_like 'framework integration'
    end
  end
end
