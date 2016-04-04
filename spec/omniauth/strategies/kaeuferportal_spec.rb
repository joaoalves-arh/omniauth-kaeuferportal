require 'spec_helper'

describe OmniAuth::Strategies::Kaeuferportal do
  def app
    lambda { |env| [200, {}, ["Hello."]] }
  end

  let(:fresh_strategy){ Class.new(OmniAuth::Strategies::Kaeuferportal) }

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    subject{ fresh_strategy }

    it 'should be initialized with symbolized client_options' do
      instance = subject.new(app, client_options: { 'authorize_url' => 'https://example.com' })
      expect(instance.client.options[:authorize_url]).to eql 'https://example.com'
    end

    it 'should set ssl options as connection options' do
      instance = subject.new(app, client_options: { 'ssl' => { 'ca_path' => 'foo' } })
      instance.client.options[:connection_opts][:ssl] =~ { ca_path: 'foo' }
    end
  end
end

