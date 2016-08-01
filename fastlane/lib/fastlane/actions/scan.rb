module Fastlane
  module Actions
    module SharedValues
      SCAN_DERIVED_DATA_PATH = :SCAN_DERIVED_DATA_PATH
    end

    class ScanAction < Action
      def self.run(values)
        require 'scan'

        begin
          FastlaneCore::UpdateChecker.start_looking_for_update('scan') unless Helper.is_test?

          Scan::Manager.new.work(values)
          Actions.lane_context[SharedValues::SCAN_DERIVED_DATA_PATH] = values[:derived_data_path] unless values[:derived_data_path].to_s.empty?

          true
        ensure
          FastlaneCore::UpdateChecker.show_update_status('scan', Scan::VERSION)
        end
      end

      def self.description
        "Easily test your app using `scan`"
      end

      def self.details
        "More information: https://github.com/fastlane/fastlane/tree/master/scan"
      end

      def self.author
        "KrauseFx"
      end

      def self.available_options
        require 'scan'
        Scan::Options.available_options
      end

      def self.is_supported?(platform)
        [:ios, :mac].include? platform
      end
    end
  end
end
