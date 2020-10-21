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

  ## Creating

  describe 'tests login in with username' do

  before :each do
    visit 'users/sign_in'
    fill_in 'Login', with: 'kells'
    fill_in 'Password', with: '123123'
    click_button 'Log in'
    visit 'users'
  end
      it 'login was made' do
      expect(page).to have_content 'Kelyn'
    end
  
end
  describe 'tests login in with email' do
    before :each do
      visit 'users/sign_in'
      fill_in 'Login', with: 'kelyn@gmail.com'
      fill_in 'Password', with: '123123'
      click_button 'Log in'
      visit 'users'
    end
    it 'login was made' do
      expect(page).to have_content 'Kelyn'
    end
    it 'users is listed in users index' do
      expect(page).to have_content 'Alex'
    end

    it 'users can add friends' do
      sleep(2)
      click_link('Add Friend', match: :first)
      expect(page).to have_content 'Friend Added'
    end

    it 'friend Requests are rendered' do
      visit 'relationships'
      expect(page).to have_content 'Friend Requests'
    end

    it 'accept Friend Request' do
      visit 'relationships'
      sleep(2)
      click_link('Accept', match: :first)
      expect(page).to have_content 'Friend request was accepted.'
    end

    it 'accept invitation button disappears if invitation accepted' do
      sleep(2)
      click_link 'Accept'
      expect(page).to_not have_content 'Accept'
    end

    it 'display list of friends posts' do
      visit 'relationships'
      click_link 'Accept'
      sleep(2)
      visit 'posts'
      expect(page).to have_content 'Test post from Chuck'
    end

    it 'if relationship was accepted create a new row for inverse relationship' do
      visit 'relationships'
      expect { click_link 'Accept' }.to change(relationship, :count).by(1)
    end
  end
end
