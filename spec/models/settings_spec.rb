require 'spec_helper'

describe Settings do
  before(:each) do
      ENV['PQ_REST_API_HOST'] = 'api_host'
      ENV['PQ_REST_API_USERNAME'] = 'username'
      ENV['PQ_REST_API_PASSWORD'] = 'password'
    end

  describe '.from_env' do
    
    it 'should call new with environment variables' do
      expect(Settings::PqRestApi).to receive(:new).with('api_host', 'username', 'password')
      Settings::PqRestApi.from_env
    end

    it 'should raise if the api-host environment var is not set' do
      ENV['PQ_REST_API_HOST'] = nil
      expect {
        Settings::PqRestApi.from_env
        }.to raise_error RuntimeError, 'Cannot find environment variable PQ_REST_API_HOST. Please set it first'
    end
  end

  
  context 'settings file values' do
    describe '.mail_from' do
      it 'should return the value from the file' do
        expect(Settings.mail_from).to eq 'PQ Team <no-reply@trackparliamentaryquestions.service.gov.uk>'
      end
    end

    describe '.mail_reply_to' do
      it 'should return the value from the file' do
        expect(Settings.mail_reply_to).to eq 'pqs@justice.gsi.gov.uk'
      end
    end

    describe '.mail_tech_support' do
      it 'should return the value from the file' do
        expect(Settings.mail_tech_support).to eq 'pqsupport@digital.justice.gov.uk'
      end
    end

    describe '.http_client_timeout' do
      it 'should return the value from the file' do
        expect(Settings.http_client_timeout).to eq 20
      end
    end

    describe '.commission_mail_from' do
      it 'should return the value from the file' do
        expect(Settings.commission_mail_from).to eq 'PQ Team <pqs@justice.gsi.gov.uk>'
      end
    end

    describe 'non existent config key' do
      it 'should raise NoMethodError' do
        expect {
          Settings.unknown_config_key
        }.to raise_error NoMethodError, "undefined method `unknown_config_key' for Settings:Module"
      end
    end
  end

end