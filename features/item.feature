Feature: Item Actions
  Make sure you can perform actions on items
  
  Scenario: Add Item
    When I add a new item "Get Milk" to "Groceries" 
    Then there should be a item called "Get Milk" in "Groceries"
