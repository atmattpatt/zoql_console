# frozen_string_literal: true

module ZoqlConsole
  module Command
    # Displays in-console help messages
    class HelpCommand
      include Base

      # Run the command
      def run
        puts <<~'HELP'
          \?        Display this help
          \config   Display configuration information
          \q        Quit the console
        HELP
      end
    end
  end
end
