require 'faraday'
module OAuthEcho
  KNOWN_PROVIDERS = { twitter: 'https://api.twitter.com/1.1/account/verify_credentials.json' }

  class Client
    def initialize(sp)
      raise UnsupportedProvider.new(sp) unless KNOWN_PROVIDERS.any? {|k,v| v == sp }
      @service_provider = sp
    end

    def request(credentials)
      connection.headers['Authorization'] = credentials
      res = connection.get @service_provider
      return Response.new(res.status, res.body)
    end

    private

    def connection
      @connection ||= Faraday.new do |conn|
        conn.adapter  Faraday.default_adapter
      end
    end
  end
end
