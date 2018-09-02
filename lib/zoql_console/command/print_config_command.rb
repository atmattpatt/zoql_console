# frozen_string_literal: true

module ZoqlConsole
  module Command
    # Displays console configuration
    class PrintConfigCommand
      include Base

      # Run the command
      def run
        first_column_size = config.keys.max(&:length).length

        config.each do |key, value|
          printf(
            "%<key>-#{first_column_size}s   %<value>-s\n",
            key: key,
            value: value,
          )
        end
      end
    end
  end
end
