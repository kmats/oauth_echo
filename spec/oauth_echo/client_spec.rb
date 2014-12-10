require 'spec_helper'
require 'faraday'
require 'json'

describe OAuthEcho::Client do
  subject(:client) { OAuthEcho::Client.new(OAuthEcho::KNOWN_PROVIDERS[:twitter]) }

  describe 'initializes with service provider' do
    context 'with known service provider' do
      it 'should succuess' do
        expect(client).to be_kind_of OAuthEcho::Client
      end
    end

    context 'with unknown service provider' do
      it 'should not succuess' do
        expect {
          OAuthEcho::Client.new("https://unknown.service.provider.com/")
        }.to raise_error(OAuthEcho::UnsupportedProvider)
      end
    end
  end

  describe 'get representation of requesting user' do
    auth_params = {
      oauth_consumer_key:     "xxxx",
      oauth_nonce:            "xxxx",
      oauth_signature:        "xxxx",
      oauth_signature_method: "HMAC-SHA1",
      oauth_timestamp:        "xxxx",
      oauth_token:            "xxxx",
      oauth_version:          "1.0",
    }

    let!(:response) { client.request(%Q!OAuth #{auth_params.map{|k,v| "k=\"#{v}\""}.join(',')}!) }
    before :each do
      allow(client).to receive(:connection).and_return(stub_connection)
    end
    context 'with valid headers' do
      let!(:stub_connection) do
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.get('/1.1/account/verify_credentials.json') do
              [ 200, {}, File.read(File.expand_path('../../fixtures/verify_credentials_example.json', __FILE__)) ]
            end
          end
        end
      end
      it "should retrieve user" do
        assert_response(response)
        expect(response.status).to eql 400
      end
    end

    context 'with invalid headers' do
      let!(:stub_connection) do
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.get('/1.1/account/verify_credentials.json') do
              [ 400, {}, '{"errors":[{"message":"Bad Authentication data","code":215}]}' ]
            end
          end
        end
      end
      it "should not retrieve user" do
        assert_response(response)
        expect(response.status).to eql 400
      end
    end

    def assert_response(response)
      expect(response).to be_kind_of OAuthEcho::Response
      expect(JSON.parse(response.body)).to be_kind_of Hash
    end
  end
end
