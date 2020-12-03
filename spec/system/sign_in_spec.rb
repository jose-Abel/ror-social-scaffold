require 'rails_helper'

RSpec.describe 'Login an existing user', type: :system do
  before :each do
    User.create(name: 'joseph', email: 'joseph@alter.ego', password: 'password')
  end

  it 'Log me in' do
    visit '/'

    sleep(2)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    email = find(:css, "input[id$='user_email']")
    email.fill_in with: 'joseph@alter.ego'

    password = find(:css, "input[id$='user_password']")
    password.fill_in with: 'password'
    sleep(2)

    find('input[name="commit"]').click

    sleep(2)

    expect(page).to have_content 'Signed in successfully.'
    sleep(2)
  end
end
