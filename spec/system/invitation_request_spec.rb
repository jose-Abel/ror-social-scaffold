# rubocop : disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe 'A log in user send and invitation and an other user accepts it', type: :system do
  before :each do
    User.create(name: 'joseph', email: 'joseph@alter.ego', password: 'password')
    User.create(name: 'john', email: 'john@alter.ego', password: 'password')
  end

  it 'Log me in' do
    visit '/'

    sleep(2)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    email = find(:css, "input[id$='user_email']")
    email.fill_in with: 'joseph@alter.ego'
    password = find(:css, "input[id$='user_password']")
    password.fill_in with: 'password'
    find('input[name="commit"]').click

    expect(page).to have_content 'Signed in successfully.'
    visit '/users'

    sleep(2)

    expect(page).to have_content 'Name: John'
    click_link 'Send invitation'

    sleep(2)

    expect(page).to have_content 'Your friendship request has been sent!'

    sleep(2)

    visit '/pending_requests'
    expect(page).to have_content 'Name: John'

    sleep(2)

    click_link 'Sign out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'

    sleep(2)

    email = find(:css, "input[id$='user_email']")
    email.fill_in with: 'john@alter.ego'
    password = find(:css, "input[id$='user_password']")
    password.fill_in with: 'password'
    find('input[name="commit"]').click

    sleep(2)

    expect(page).to have_content 'Signed in successfully.'
    visit '/friends_requests'
    click_link 'Accept Friendship'

    sleep(2)

    expect(page).to have_content 'Friend request has been accepted!'
    visit '/friends_list'
    expect(page).to_not have_content 'Error!'

    sleep(2)
  end
end

# rubocop : enable Metrics/BlockLength
