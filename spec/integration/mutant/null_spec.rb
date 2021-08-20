# frozen_string_literal: true

RSpec.describe 'null integration', mutation: false do

  let(:base_cmd) { 'bundle exec mutation -I lib --require test_app "TestApp*"' }

  around do |example|
    Dir.chdir(TestApp.root) do
      example.run
    end
  end

  specify 'it allows to kill mutations' do
    expect(Kernel.system(base_cmd)).to be(false)
  end
end
