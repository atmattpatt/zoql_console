# frozen_string_literal: true

require "forwardable"

module ZoqlConsole
  # Configuration for the query console
  class Config
    extend Forwardable
    include Enumerable

    def_delegators :to_h, :each, :keys

    # Zuora connection config

    # @return [String] hostname for connecting to Zuora
    attr_accessor :zuora_host

    class << self
      # @return [Config] the default configuration
      def default
        config = new

        # Zuora connection config
        config.zuora_host = "zuora.com"

        config
      end
    end

    # @return [Hash] hash of all configuration settings
    def to_h
      {
        zuora_host: zuora_host,
      }
    end
  end
end
