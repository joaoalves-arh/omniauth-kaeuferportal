require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Kaeuferportal < OmniAuth::Strategies::OAuth2
      option :name, "kaeuferportal"
      option :client_options, {
        site: 'https://auth.kaeuferportal.de',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }

      uid { user_info['sub'] }

      info do
        {
          name: user_info['name'],
          email: user_info['email']
        }
      end

      def user_info
        @user_info ||= access_token.get('/api/users/current').parsed
      end

      # This method override was once part of omniauth-oauth2, but was removed
      # in https://github.com/intridea/omniauth-oauth2/pull/70
      # However, this causes Doorkeeper to reject the redirect_uri, as I explain
      # here: https://github.com/intridea/omniauth-oauth2/issues/28#issuecomment-199382532
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
OmniAuth.config.add_camelization 'kaeuferportal', 'Kaeuferportal'
