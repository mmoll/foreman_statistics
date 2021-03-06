module ForemanStatistics
  module Statistics
    class Base
      attr_reader :title, :count_by, :url

      def initialize(options = {})
        @id = options[:id]
        @title = options[:title]
        @search = options[:search]
        @count_by = options[:count_by]
        @organization_id = options[:organization_id]
        @location_id = options[:location_id]
        @url = options[:url] || build_url
      end

      def calculate
        raise NotImplementedError, "Method 'calculate' method needs to be implemented"
      end

      def id
        @id || count_by.to_s
      end

      def search
        Rails.application.routes.url_helpers.hosts_path(:search => @search)
      end

      def metadata
        { :id => id, :title => title, :url => url, :search => search }
      end

      private

      def build_url
        ForemanStatistics::Engine.routes.url_helpers.statistic_path(id, :location_id => @location_id, :organization_id => @organization_id)
      end
    end
  end
end
