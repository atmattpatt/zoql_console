# frozen_string_literal: true

module ZoqlConsole
  module Command
    # Displays console configuration
    module Base
      # Add class methods
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      # Class methods for all command objects
      module ClassMethods
        # Run the command
        #
        # @param [ZoqlConsole::Config] configuration object
        def run(config:)
          new(config: config).run
        end
      end

      # @return [ZoqlConsole::Config] configuration object
      attr_reader :config

      # Initialize the command
      #
      # @param [ZoqlConsole::Config] configuration object
      def initialize(config:)
        @config = config
      end

      # Run the command
      def run
        raise NotImplementedError
      end
    end
  end
end
