class Singly::Service
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def get(path, query={})
    client.get("/services/#{service_name}#{path}", query)
  end

  def service_name
    self.class.name.demodulize.downcase
  end
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'service', '*'))].each do |service|
  require "singly/service/#{service.split('/').last.split('.').first}"
end
