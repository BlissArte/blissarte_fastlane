require 'spaceship/connect_api/blissarte/client'

module Spaceship
  class ConnectAPI
    module BlissArte
      module API
        module Version
          V1 = "v1"
        end

        def blissarte_request_client=(blissarte_request_client)
          @blissarte_request_client = blissarte_request_client
        end

        def blissarte_request_client
          return @blissarte_request_client if @blissarte_request_client
          raise TypeError, "You need to instantiate this module with blissarte_request_client"
        end

        #
        # App Events
        #

        def get_app_events(app_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
          params = blissarte_request_client.build_params(filter: filter, includes: includes, limit: limit, sort: sort)
          resps = blissarte_request_client.get("#{Version::V1}/apps/#{app_id}/appEvents", params)
          return resps
        end

        def create_app_event(attributes: nil)
          body = {
            data: {
              type: "appEvents",
              attributes: attributes
            }
          }

          blissarte_request_client.post("#{Version::V1}/appEvents", body)
        end

        def patch_app_event(app_event_id: nil, attributes: nil)
          body = {
            data: {
              type: "appEvents",
              id: app_event_id,
              attributes: attributes
            }
          }
          blissarte_request_client.patch("#{Version::V1}/appEvents/#{app_event_id}", body)
        end

        def delete_app_event(app_event_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
          params = client.build_params(filter: filter, includes: includes, limit: limit, sort: sort)
          blissarte_request_client.delete("#{Version::V1}/appEvents/#{app_event_id}", params)
        end

        #
        # App Event Localizations
        #
        def get_app_event_localizations(app_event_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
          params = blissarte_request_client.build_params(filter: filter, includes: includes, limit: limit, sort: sort)
          blissarte_request_client.get("#{Version::V1}/appEvents/#{app_event_id}/localizations", params)
        end

        def create_app_event_localization(app_event_id: nil, attributes: nil)
          body = {
            data: {
              type: "appEventLocalizations",
              attributes: attributes,
              relationships: {
                appEvent: {
                  data: {
                    type: "appEvents",
                    id: app_event_id
                  }
                }
              }
            }
          }

          blissarte_request_client.post("#{Version::V1}/appEventLocalizations", body)
        end

        def patch_app_event_localization(app_event_localization_id: nil, attributes: nil)
          body = {
            data: {
              type: "appEventLocalizations",
              id: app_event_localization_id,
              attributes: attributes
            }
          }
          blissarte_request_client.patch("#{Version::V1}/appEventLocalizations/#{app_event_localization_id}", body)
        end

        def delete_app_event_localization(app_event_localization_id: nil, filter: {}, includes: nil, limit: nil, sort: nil)
          params = client.build_params(filter: filter, includes: includes, limit: limit, sort: sort)
          blissarte_request_client.delete("#{Version::V1}/appEventLocalizations/#{app_event_localization_id}", params)
        end
      end
    end
  end
end
