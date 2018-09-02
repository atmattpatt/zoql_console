Feature: Console commands

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
