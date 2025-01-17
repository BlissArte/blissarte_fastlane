require_relative '../api_client'
require_relative './blissarte'
require_relative '../../tunes/tunes_client'

module Spaceship
  class ConnectAPI
    module BlissArte
      class Client < Spaceship::ConnectAPI::APIClient
        def initialize(cookie: nil, current_team_id: nil, token: nil, another_client: nil)
          another_client ||= Spaceship::Tunes.client if cookie.nil? && token.nil?

          super(cookie: cookie, current_team_id: current_team_id, token: token, another_client: another_client)

          self.extend(Spaceship::ConnectAPI::BlissArte::API)
          self.blissarte_request_client = self
        end

        def self.hostname
          'https://api.appstoreconnect.apple.com/'
        end
      end
    end
  end
end
