Feature: List Actions
  Make sure you can perform actions on lists
  
  Scenario: Add List
    When I add a new list "Groceries"
    Then there should be a list titled "Groceries"
