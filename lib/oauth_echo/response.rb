module OAuthEcho
  class Response
    attr_reader :status, :body
    def initialize(status, body)
      @status = status
      @body = body
    end

    def success?
      @status == '200'
    end

    def identity
      success? ? JSON.parse(@body) : nil
    end
  end
end
