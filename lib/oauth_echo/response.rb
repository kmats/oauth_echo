module OAuthEcho
  class Response
    attr_reader :status, :body
    def initialize(status, body)
      @status = status
      @body = body
    end

    def success?
      @status.to_i == 200
    end

    def user_info
      success? ? JSON.parse(@body) : nil
    end
  end
end
