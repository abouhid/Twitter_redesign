require 'rails_helper.rb'
require 'spec_helper'

describe 'the signin process', type: :feature do
  before :each do
    @test_friend = User.create!({ name: 'Alex',
                                  email: '123@gmail.com',
                                  password: '123123',
                                  password_confirmation: '123123' })
    @test_user = User.create!({ name: 'Kelyn',
                                email: '234@gmail.com',
                                password: '123123',
                                password_confirmation: '123123' })
    @tweet = tweet.create!({ user_id: @test_friend.id,
                           content: 'Test tweet!' })
    visit 'users/sign_in'
    fill_in 'user_email', with: @test_friend.email
    fill_in 'user_password', with: @test_friend.password
    click_button('Log in')
  end
  it 'Display message when creating a tweet' do
    visit '/tweets'

    find('.form-control', match: :first).set('Testing first tweet!')
    click_button('Save')

    expect(page).to have_content 'tweet was successfully created.'
  end
end
