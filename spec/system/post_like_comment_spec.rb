require 'rails_helper'

RSpec.describe 'A log in user creates an event, comments and likes it', type: :system do
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

    find('input[name="commit"]').click

    sleep(2)

    expect(page).to have_content 'Signed in successfully.'

    visit '/posts'

    content = find(:css, "input[id$='post_content']")
    content.fill_in with: 'Hello, this is my first post!'

    find('input[name="commit"]').click

    sleep(2)

    expect(page).to have_content 'Post was successfully created.'

    content_comment = find(:css, "input[id$='comment_content']")
    content_comment.fill_in with: 'Amazing comment!!! <3'

    find("input[value='Comment']").click

    sleep(2)

    click_link 'Like!'

    sleep(2)
  end
end
