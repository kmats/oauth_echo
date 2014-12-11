require 'spec_helper'

describe OAuthEcho::Response do
  context 'when OAuth echo was success' do
    subject { OAuthEcho::Response.new(200, File.read(File.expand_path('../../fixtures/verify_credentials_example.json', __FILE__))) }
    it { is_expected.to be_success }
    it { is_expected.to have_attributes(status: 200) }
    it { is_expected.to have_attributes(user_info: a_kind_of(Hash)) }
  end

  context 'when OAuth echo was failed' do
    subject { OAuthEcho::Response.new(400, '{"errors":[{"message":"Bad Authentication data","code":215}]}') }
    it { is_expected.not_to be_success }
    it { is_expected.to have_attributes(status: 400) }
    it { is_expected.to have_attributes(user_info: nil) }
  end
end
