When(/^I go to the "(.*?)"$/) do |page|
  if (page == 'Home Page')
    visit 'http://localhost:3000/'
  else
  	visit page
  end
end

Then(/^there I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
