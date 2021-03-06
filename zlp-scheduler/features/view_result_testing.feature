Feature: An Admin can view the result
  As an administrator
  so that I can run the algorithm
  I want to be able to view the result.
  
Background: log in as an admin
  Given the following terms exist:
  | name          |
  | Test Term     |
  And the active term is "Test Term"
  And the following cohorts exist:
  | name          |
  | Test Cohort   |
  And "Test Cohort" is in the current term
  And I am logged in as an admin

Scenario: View the view result and non-conflict result
  When I click "Test Cohort"
  Then I should see the view cohort page for Test Cohort 
  When I click "Run Algorithm"
  Then I should see the view cohort page for Test Cohort 
  When I click "Find Class Time"
  Then I should see the view result page for Test Cohort
  When I click button "Choose"
  Then I should see the select time page for Test Cohort




