$: << File.expand_path(File.join(File.dirname(__FILE__), 'support'))

require "json"
require "singly"
require "webmock/rspec"
require "stub_api"

WebMock.disable_net_connect!

RSpec.configure do |c|
  c.include StubApi
end
