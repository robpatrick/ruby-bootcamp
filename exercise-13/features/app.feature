Feature: Login page

  Scenario: Enter the login page
    Given I am on the login page
    Then I should see the login page

  Scenario: Invalid login credentials
    Given I am on the login page
    When I enter the login credentials "wrong@username.com" and "password"
    Then I expect to see the unauthorised page

  Scenario: Valid login credentials
    Given I am on the login page
    When I enter the login credentials "admin@thing.com" and "admin"
    Then I expect to see the bill viewer page