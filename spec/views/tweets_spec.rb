require 'rails_helper.rb'
require 'spec_helper'

describe 'the signin process', type: :feature do
  before :each do
    @test_user1 = User.create!({ fullname: 'Kelyn',
                                  username: 'kells',
                                  email: 'kelyn@gmail.com',
                                  password: '123123',
                                  password_confirmation: '123123' })
    @test_user2 = User.create!({ fullname: 'Alex',
                                username: 'abouhid',
                                email: 'alex@gmail.com',
                                password: '123123',
                                password_confirmation: '123123' })
    @test_user1_follow = User.create!({ fullname: 'Chuck',
                                          username: 'chucky',
                                          email: 'chuckster@gmail.com',
                                          password: '123123',
                                          password_confirmation: '123123' })
    @relationship = Relationship.create!({ follower_id: @test_user1_follow.id,
                                       followed_id: @test_user1.id })

    @tweet = Tweet.create!({ author_id: @test_user1_follow.id,
                           content: 'Test post from Chuck', id: 1 })
    visit 'users/sign_in'
    fill_in 'Login', with: @test_user1.email
    fill_in 'user_password', with: @test_user1.password
    click_button('Log in')
  end

  it 'Display message when creating a tweet' do
    visit '/'
    find('.input', match: :first).set('Testing first tweet!')
    click_button("Create Tweet")
    expect(page).to have_content 'Tweet was successfully created.'
  end

  it 'Display message when deleting a tweet' do
    visit '/'
    find('.input', match: :first).set('Testing first tweet!')
    click_button("Create Tweet")
    find('.delete').click
    expect(page).not_to have_css(".like", text: "Testing first tweet!")
   
  end
  it 'Display message when editing a tweet' do
  
    visit '/'
    find('.input', match: :first).set('Testing first tweet!')
    click_button("Create Tweet")
    find('.edit').click

    find('.input', match: :first).set('Editing first tweet!')
    click_button("Update Tweet")
    expect(page).to have_content 'Tweet was successfully updated.'
  end

end
