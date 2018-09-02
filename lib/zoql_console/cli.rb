# frozen_string_literal: true

require "optparse"
require "readline"

module ZoqlConsole
  # Entry point for CLI program
  class CLI
    class << self
      # Start a CLI program
      #
      # @param argv [Hash] Command line arguments
      def start(argv)
        new(argv).start
      end
    end

    # Initialize CLI program
    #
    # @param argv [Hash] Command line arguments
    def initialize(argv)
      @argv = argv
      @console = Console.new
    end

    # Start CLI program
    def start
      option_parser.parse(@argv)
      @console.start
    end

    private

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.on("-h", "--help", "Display this help message and exit") do
          puts version
          puts opts
          exit
        end

        opts.on("-V", "--version", "Output version information and exit") do
          puts version
          exit
        end
      end
    end

    def version
      "zoql_console #{ZoqlConsole::VERSION}"
    end
  end
end
