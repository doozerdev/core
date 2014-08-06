When(/^I add a new list "(.*?)"$/) do |list_name|
  visit 'http://localhost:3000/items/new/'
  fill_in 'item[title]', :with => 'list_name'
  click_button 'Create List'
end

Then(/^there should be a list titled "(.*?)"$/) do |list_name|
  expect(page).to have_content('Item was successfully created')
  #expect(page).to have_link(list_name)
end
