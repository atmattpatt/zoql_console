# frozen_string_literal: true

require "readline"

module ZoqlConsole
  # Entry point for CLI console
  class CLI
    class << self
      # Start a CLI console
      def start
        new.start
      end
    end

    # Start a CLI console
    def start
      loop do
        buffer = Readline.readline("zoql> ", true)

        if exit?(buffer)
          puts "Bye!"
          break
        end
      end
    end

    private

    def exit?(buffer)
      buffer = buffer.split
      buffer.first == '\q' || buffer.first == "exit"
    end
  end
end
