Feature: Classroom Setting for different teacher subscriptions


  Scenario: Verify show student username setting is displayed for premium teacher
    Given the user login as premium teacher
    When the application navigates to the teacher home page
    And the user clicks on option dropdown icon
    And the user clicks on classroom setting icon
    Then the show student username setting should be displayed
    And student username and password should be displayed when setting is turned on
    And student username and password should not be displayed when setting is turned off