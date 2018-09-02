# frozen_string_literal: true

require "readline"

module ZoqlConsole
  # ZOQL query console
  class Console
    # Initialize interactive console
    def initialize
      @interpreter = Interpreter.new
    end

    # Start the interactive console
    def start
      loop do
        @interpreter.buffer = Readline.readline("zoql> ", true)
        next if @interpreter.blank?

        if @interpreter.exit?
          puts "Bye!"
          break
        end

        command = @interpreter.command
        command&.run
      end
    end
  end
end
