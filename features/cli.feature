Feature: Command line interface

  Scenario: Displaying gem version
    When I run zoql with "--version"
    Then the console should exit
    And the output should match "zoql_console \d+\.\d+\.\d+"

  Scenario: Displaying CLI help
    When I run zoql with "--help"
    Then the console should exit
    And the output should match "--help\s+Display this help message"
    And the output should match "--version\s+Output version information"
