Feature: Authentication
  In order to use the website
  As a user
  I should be able to sign up, log in and log out

Scenario: student login success
  Given I am a registered student
  And I visit the index page
  When I fill in the login form
  Then I should be logged in

Scenario: A logged in student sees closed page if he/she is not in the active cohort
  Given I am a registered student
  And I am not in the active cohort
  And I am logged in
  Then I should see the closed page

Scenario: A logged in student sees terms page if he/she is in the active cohort
  Given I am a registered student
  And I am in the active cohort
  And I am logged in
  Then I should see the terms page

Scenario: Student login Failed
  Given I am not a registered student
  And I visit the index page
  When I fill in the login form
  Then I should not be logged in

Scenario: Student logout
  Given I am a registered student
  And I am logged in
  When I click on the log out link
  Then I should be redirected to the login page

Scenario: Administrator login success
  Given I am a registered admin
  And I visit the index page
  When I fill in the login form
  Then I should be logged in

Scenario: A logged in administrator sees view term page
  Given I am a registered admin
  And I am logged in
  Then I should see the admin terms page

Scenario: A Administrator Failed
  Given I am not a registered admin
  And I visit the index page
  When I fill in the login form
  Then I should not be logged in

Scenario: Administrator logout
  Given I am a registered admin
  And I am logged in
  When I click on the log out link
  Then I should be redirected to the login page

Scenario: A student Reset Password
  Given I am a registered student
  And I visit the index page
  When I click on the forgot password link
  And I fill in the password reset form
  And I confirm the reset
  Then I should see the reset instructions