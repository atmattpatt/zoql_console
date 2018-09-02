Feature: Configuration

  Scenario: Configuring the Zuora host
    When I run zoql with "--zuora-host apisandbox.zuora.com"
    And I send command "\config"
    Then the console should still be running
    Then the output should match "zuora_host\s+apisandbox.zuora.com"
