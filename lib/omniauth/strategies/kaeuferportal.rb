require 'omniauth/strategies/oauth2'

module OAuth2
  class Client
    def get_token(params, access_token_opts={})
      opts = {:raise_errors => true, :parse => params.delete(:parse)}
      if options[:token_method] == :post
        opts[:body] = params
        opts[:headers] =  {'Content-Type' => 'application/x-www-form-urlencoded'}
      else
        opts[:params] = params
      end
      response = request(options[:token_method], token_url, opts)
      raise Error.new(response) unless response.body['access_token']
      opts = {
        :access_token => response.body.split("=")[1],
        :param_name => 'token'
      }
      AccessToken.from_hash(self, opts.merge(access_token_opts))
    end
  end
end

module OmniAuth
  module Strategies
    class Kaeuferportal < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "kaeuferportal"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://www.kaeuferportal.de',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/access_token'
      }

      def request_phase
        redirect client.auth_code.authorize_url({:redirect_url => callback_url}.merge(authorize_params))
      end

      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(verifier, {:redirect_url => callback_url}.merge(options.token_params.to_hash(:symbolize_keys => true)))
      end

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['uuid'] }

      info do
        {
          :name => @raw_info['email'].split("@")[0],
          :email => @raw_info['email']
        }
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'oauth_token'
        @raw_info ||= access_token.get('/oauth/user').parsed
      end
    end
  end
end
OmniAuth.config.add_camelization 'kaeuferportal', 'Kaeuferportal'
