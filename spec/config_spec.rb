require "spec_helper"

RSpec.describe Browet::Config do
  include EntityHelpers

  context "when invalid config" do
    it "raise empty account error" do
      Browet::Config.account = ''
      Browet::Config.default_token = ''
      expect { Browet::Group.list }.to raise_error(Browet::ConfigError)
    end

    it "raise empty default_token error" do
      Browet::Config.account = 'account'
      Browet::Config.default_token = ''
      expect { Browet::Group.list }.to raise_error(Browet::ConfigError)
    end
  end

  context "when correct config" do
    before(:example) do
      config_init
    end

    it "has correct url" do
      expect(Browet::Config.api_url).to eq('http://account.browet.com/api/v1')
    end

    context "when invalid account" do
      before(:example) do
        init_invalid_account
      end

      it "raise http error" do
        expect { Browet::Group.list }.to raise_error(Browet::HttpError)
      end
    end

    context "when server timeout" do
      before(:example) do
        init_server_timeout
      end

      it "raise http error" do
        expect { Browet::Product.list }.to raise_error(Timeout::Error)
      end
    end
   
  end

end
