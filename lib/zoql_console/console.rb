# frozen_string_literal: true

require "readline"

module ZoqlConsole
  # ZOQL query console
  class Console
    # Initialize interactive console
    #
    # @param config [ZoqlConsole::Config] configuration object
    def initialize(config:)
      @interpreter = Interpreter.new
      @config = config
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
        command&.run(config: @config)
      end
    end
  end
end
