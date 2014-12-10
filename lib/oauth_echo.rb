require "oauth_echo/version"
require "oauth_echo/client"
require "oauth_echo/error"
require "oauth_echo/response"

module OAuthEcho
  class << self
    def has_header?(headers)
      return false unless headers.respond_to? :[]
      headers.has_key?('X-Auth-Service-Provider') ||
      headers.has_key?('X-Verify-Credentials-Authorization')
    end
  end
end
