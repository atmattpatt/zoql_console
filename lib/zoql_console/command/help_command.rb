# frozen_string_literal: true

module ZoqlConsole
  module Command
    # Displays in-console help messages
    class HelpCommand
      class << self
        # Run the command
        def run
          new.run
        end
      end

      # Run the command
      def run
        puts <<~'HELP'
          \? Display this help
          \q Quit the console
        HELP
      end
    end
  end
end
