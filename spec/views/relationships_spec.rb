require 'rails_helper.rb'

describe 'testing relationship features', type: :feature do
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
                                password_confirmation: '123123',
                                id: 1 })
    @test_user1_follow = User.create!({ fullname: 'Chuck',
                                          username: 'chucky',
                                          email: 'chuckster@gmail.com',
                                          password: '123123',
                                          password_confirmation: '123123' })
    @relationship = Relationship.create!({ follower_id: @test_user1_follow.id,
                                       followed_id: @test_user1.id })

    @post = Tweet.create!({ author_id: @test_user1_follow.id,
                           content: 'Test post from Chuck' })
                           visit 'users/sign_in'
                           fill_in 'Login', with: 'kelyn@gmail.com'
                           fill_in 'Password', with: '123123'
                           click_button 'Log in'
                           visit 'users'
  end


    it 'Able to see other users in index page' do
      visit 'users'
      expect(page).to have_content 'Alex'
    end
    it 'Able to see other users in show page' do
      visit 'users/1'
      expect(page).to have_content 'Alex'
    end

    it 'able to follow' do
      visit 'users/1'
      find('#follow').click
      expect(page).to have_css("#unfollow")
    end

    it 'able to unfollow' do
      visit 'users/1'
      find('#follow').click
      find('#unfollow').click
      expect(page).to have_css("#follow")
    end
  end
