# frozen_string_literal: true

require "zoql_console/completor/commands"
require "zoql_console/completor/zuora_objects"

module ZoqlConsole
  # Console command completion
  class Completor
    # Initialize completion engine
    #
    # @param config [ZoqlConsole::Config] configuration object
    def initialize(config:)
      @config = config
    end

    # Find completions for a given input
    #
    # @param input [String] the input string to complete
    # @return [Array<String>] possible completions
    def complete(input)
      regexp = Regexp.new("^" + Regexp.escape(input))
      (
        command_completions(regexp) +
        zuora_object_completions(regexp)
      )
    end

    private

    # Find completions for console commands
    #
    # Note the input will not contain a leading '\'
    #
    # @param regexp [Regexp] the input string as a regular expression
    # @return [Array<String>] possible completions
    def command_completions(regexp)
      COMMANDS.grep(regexp)
    end

    # Find completions for Zuora objects
    #
    # @param regexp [Regexp] the input string as a regular expression
    # @return [Array<String>] possible completions
    def zuora_object_completions(regexp)
      ZUORA_OBJECTS.grep(regexp)
    end
  end
end
