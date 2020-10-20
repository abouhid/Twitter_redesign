# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @tweets = Tweet.all.order('created_at DESC')
    @tweet = Tweet.new
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
