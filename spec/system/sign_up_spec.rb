require 'rails_helper'

RSpec.describe 'Registration of a new user', type: :system do
  it 'Register a new' do
    visit '/'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    click_link 'Sign up'
    sleep(2)

    expect(page).to have_content 'Sign up'

    name = find(:css, "input[id$='user_name']")
    name.fill_in with: 'joseph'

    email = find(:css, "input[id$='user_email']")
    email.fill_in with: 'joseph@alter.ego'

    password = find(:css, "input[id$='user_password']")
    password.fill_in with: 'password'

    password_conf = find(:css, "input[id$='user_password_confirmation']")
    password_conf.fill_in with: 'password'
    sleep(2)

    find('input[name="commit"]').click
    sleep(2)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
