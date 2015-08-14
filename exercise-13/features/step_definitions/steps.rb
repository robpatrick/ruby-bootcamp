Given(/^I am on the login page$/) do
  visit 'http://localhost:9292/login'
end

Then( /^I should see the login page$/ ) do
  page.has_content? 'Login'
end

When(/^I enter the login credentials "([^"]*)" and "([^"]*)"$/) do |email, password|
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_on 'Log in'
end

Then(/^I expect to see the unauthorised page$/) do
  page.has_content? 'Unauthorised'
end

Then(/^I expect to see the bill viewer page$/) do
  page.has_content? 'Your bill'
end