Feature: Console commands

  Scenario: Displaying console help
    Given a running console
    When I send command "\?"
    Then the console should still be running
    And the output should match "\\\?\s+Display this help"
    And the output should match "\\q\s+Quit the console"

  Scenario: Quitting the console with "\q"
    Given a running console
    When I send command "\q"
    Then the console should exit
    And the exit status should be 0
    And the output should contain "Bye!"

  Scenario: Quitting the console with "exit"
    Given a running console
    When I send command "exit"
    Then the console should exit
    And the exit status should be 0
    And the output should contain "Bye!"
