require_relative '../model'
require_relative '../../errors'
module Spaceship
  class ConnectAPI
    class AppEventLocalization
      module Version
        V1 = "v1"
      end
      include Spaceship::ConnectAPI::Model

      attr_accessor :locale
      attr_accessor :name
      attr_accessor :short_description
      attr_accessor :long_description

      attr_mapping({
        "locale" => "locale",
        "name" => "name",
        "shortDescription" => "short_description",
        "longDescription" => "long_description"
      })

      def self.type
        return "appEventLocalizations"
      end

      #
      # API
      #

      def update(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        attributes ||= {}
        client.patch_app_event_localization(app_event_localization_id: id, attributes: reverse_attr_mapping(attributes))
      rescue
        raise Spaceship::AppStoreLocalizationError, @locale
      end

      def delete!(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_app_event_localization(app_event_localization_id: id, filter: filter, includes: includes, limit: limit, sort: sort)
      rescue
        raise Spaceship::AppStoreLocalizationError, @locale
      end
    end
  end
end
