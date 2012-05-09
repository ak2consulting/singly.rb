module StubApi
  RESPONSE_PATH = File.expand_path(File.join(
    File.dirname(__FILE__), '..', 'fixtures')
  )

  def stub_api(client, path, code)
    stub_request(:any, /^#{client.api_url(path)}.*/).
      to_return(
        :status => code,
        :body => api_fixture(path, code)
      )
  end

  def api_fixture(path, code)
    fixture_path = api_fixture_path(path, code)
    File.exist?(fixture_path) ? File.new(api_fixture_path(path, code)) : ''
  end

  def api_fixture_path(path, code)
    File.join(RESPONSE_PATH, path, code.to_s) + '.json'
  end
end
