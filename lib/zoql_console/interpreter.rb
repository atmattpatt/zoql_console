# frozen_string_literal: true

require "readline"

require "zoql_console/command/help_command"

module ZoqlConsole
  # Console command interpreter
  class Interpreter
    # @return [String] the input buffer being interpreted
    attr_reader :buffer

    # Set the input buffer
    #
    # @param input [String] the input to be interpreted
    def buffer=(input)
      @buffer = input
      @words = nil
    end

    # return [Boolean] whether or not the buffer is blank
    def blank?
      words.empty?
    end

    # return [Object] command that will handle the given input
    def command
      case first
      when '\?' then Command::HelpCommand
      else
        puts "Unknown command: #{buffer}"
      end
    end

    # @return [Boolean] whether or not this is an exit command
    def exit?
      first == '\q' || first == "exit"
    end

    private

    # @return [Array] the input buffer split into words
    def words
      @words ||= (buffer || "").split
    end

    # @return [String] the first word from the input
    def first
      words&.first
    end
  end
end
