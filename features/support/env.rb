# frozen_string_literal: true

require "pty"

module ZoqlConsole
  # Fixtures for supporting tests
  module TestSupport
    # The path to the console command
    # @return [String] The path to the console command
    def console_command
      File.expand_path("../../bin/zoql", __dir__)
    end
  end
end

include ZoqlConsole::TestSupport
