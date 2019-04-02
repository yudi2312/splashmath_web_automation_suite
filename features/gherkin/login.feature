Feature: This feature consist of various login/sign-in scenarios

  @teacher @login
  Scenario: Verify user is able to log-in as a teacher
    Given the user login as teacher
    Then teacher dashboard should be displayed

  @parent @login
  Scenario: Verify user is able to log-in as a parent
    Given the user login as parent
    And the user clicks on parent icon
    Then parent dashboard should be displayed

  @student @login
  Scenario: Verify user is able to log-in as a student
    Given the user login as student
    Then student dashboard should be displayed

  @student @login
  Scenario: Verify student log-in from parent
    Given the user login as student_parent
    And the user selects student on Select Account Page
    Then student dashboard page should be displayed