require 'spec_helper'

describe OAuthEcho do
  it 'should have a version number' do
    expect(OAuthEcho::VERSION).to match(/\A\d+\.\d+\.\d+\Z/)
  end

  auth_headers = %w(X-Auth-Service-Provider X-Verify-Credentials-Authorization)

  describe 'tells wheather request has auth headers' do
    auth_headers.each do |header|
      context "with #{header}" do
        subject(:headers) { {header => "hoge"} }
        it "returns true" do
          expect(OAuthEcho.has_header?(headers)).to eql true
        end
      end
    end

    context "without #{auth_headers.join(',')}" do
      subject(:headers) { {} }
      it "returns false" do
        expect(OAuthEcho.has_header?(headers)).to eql false
      end
    end
  end
end
