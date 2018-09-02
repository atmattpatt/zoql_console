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
      @config = Config.default
      @console = Console.new(config: @config)
    end

    # Start CLI program
    def start
      option_parser.parse(@argv)
      @console.start
    end

    private

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        # Informational options
        opts.on("-h", "--help", "Display this help message and exit") do
          puts version
          puts opts
          exit
        end

        opts.on("-V", "--version", "Output version information and exit") do
          puts version
          exit
        end

        # Zuora connection options
        opts.on("-h HOSTNAME", "--zuora-host=HOSTNAME", "Use HOSTNAME for connecting to Zuora") do |hostname|
          @config.zuora_host = hostname
        end
      end
    end

    def version
      "zoql_console #{ZoqlConsole::VERSION}"
    end
  end
end
