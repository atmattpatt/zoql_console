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
    end

    # Start a CLI program
    def start
      option_parser.parse(@argv)
      console
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

    def console
      loop do
        buffer = Readline.readline("zoql> ", true)

        if exit?(buffer)
          puts "Bye!"
          break
        elsif help?(buffer)
          puts '\? Display this help'
          puts '\q Quit the console'
        end
      end
    end

    def help?(buffer)
      buffer = buffer.split
      buffer.first == '\?'
    end

    def exit?(buffer)
      buffer = buffer.split
      buffer.first == '\q' || buffer.first == "exit"
    end
  end
end
