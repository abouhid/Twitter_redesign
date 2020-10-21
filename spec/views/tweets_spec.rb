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

    @post = Tweet.create!({ author_id: @test_user1_follow.id,
                           content: 'Test post from Chuck' })
  end

  it 'Display message when creating a tweet' do
    visit '/'

    find('.input', match: :first).set('Testing first tweet!')
    page.find("#create-tweet").click
    expect(page).to have_content 'Tweet was successfully created.'
  end
end
