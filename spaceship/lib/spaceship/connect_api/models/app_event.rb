require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppEvent
      module Version
        V1 = "v1"
      end
      include Spaceship::ConnectAPI::Model

      attr_accessor :archived_territory_schedules
      attr_accessor :territory_schedules
      attr_accessor :badge
      attr_accessor :deep_link
      attr_accessor :event_state
      attr_accessor :primary_locale
      attr_accessor :priority
      attr_accessor :purchaseRequirement
      attr_accessor :purpose
      attr_accessor :referenceName

      module Badge
        LIVE_EVENT = "LIVE_EVENT"
        PREMIERE = "PREMIERE"
        CHALLENGE = "CHALLENGE"
        COMPETITION = "COMPETITION"
        NEW_SEASON = "NEW_SEASON"
        MAJOR_UPDATE = "MAJOR_UPDATE"
        SPECIAL_EVENT = "SPECIAL_EVENT"
      end

      module EventState
        DRAFT = "DRAFT"
        READY_FOR_REVIEW = "READY_FOR_REVIEW"
        WAITING_FOR_REVIEW = "WAITING_FOR_REVIEW"
        IN_REVIEW = "IN_REVIEW"
        REJECTED = "REJECTED"
        ACCEPTED = "ACCEPTED"
        APPROVED = "APPROVED"
        PUBLISHED = "PUBLISHED"
        PAST = "PAST"
        ARCHIVED = "ARCHIVED"
      end

      module Priority
        HIGH = "HIGH"
        NORMAL = "NORMAL"
      end

      module PurchaseRequirement
        NO_COST_ASSOCIATED = "NO_COST_ASSOCIATED"
        IN_APP_PURCHASE = "IN_APP_PURCHASE"
      end

      module Purpose
        APPROPRIATE_FOR_ALL_USERS = "APPROPRIATE_FOR_ALL_USERS"
        ATTRACT_NEW_USERS = "ATTRACT_NEW_USERS"
        KEEP_ACTIVE_USERS_INFORMED = "KEEP_ACTIVE_USERS_INFORMED"
        BRING_BACK_LAPSED_USERS = "BRING_BACK_LAPSED_USERS"
      end

      attr_mapping({
        "archivedTerritorySchedules" => "archived_territory_schedules",
        "territorySchedules" => "territory_schedules",
        "badge" => "badge",
        "deepLink" => "deep_link",
        "eventState" => "event_state",
        "primaryLocale" => "primary_locale",
        "priority" => "priority",
        "purchaseRequirement" => "purchase_requirement",
        "purpose" => "purpose",
        "referenceName" => "reference_name"
      })

      ESSENTIAL_INCLUDES = [
        "badge",
        "deepLink",
        "eventState",
        "primaryLocale",
        "priority",
        "purchaseRequirement",
        "purpose",
        "referenceName"
      ].join(",")

      def self.type
        return "appEvents"
      end

      #
      # API
      #

      def update
        client ||= Spaceship::ConnectAPI
        attributes ||= {}
        client.patch_app_event(app_event_id: id, attributes: reverse_attr_mapping(attributes))
      end

      def delete!(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_app_event(app_event_id: id, filter: filter, includes: includes, limit: limit, sort: sort) 
      end

      #
      # App Event Localizations
      #

      def create_app_event_localization(client: nil, attributes: nil)
        reversed_attributes = Spaceship::ConnectAPI::AppEventLocalization.new(nil, {}).reverse_attr_mapping(attributes)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_event_localization(app_event_id: id, attributes: reversed_attributes)
        return resp.to_models.first
      end

      def get_app_event_localizations(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_app_event_localizations(app_event_id: id, filter: filter, includes: includes, limit: limit, sort: sort).all_pages
        return resps.flat_map(&:to_models)
      end
    end
  end
end
