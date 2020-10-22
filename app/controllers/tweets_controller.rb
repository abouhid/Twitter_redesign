class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @likes = Like.all
    @tweets = Tweet.all.order('created_at DESC').includes(%i[user replies])
    @users = User.order('created_at DESC').includes(%i[followed_users followers replies tweets])
    if current_user
      @tweet = current_user.tweets.new
      @not_followed = User.all.order('created_at DESC') - current_user.followed_users
      @not_followed.delete(current_user)
      
      ids = current_user.followed_users.ids
      ids << current_user.id
      # @followed_and_user_tweets = @tweets.where("author_id = #{current_user.id}")
      @followed_and_user_tweets = @tweets.where(author_id: ids)

    end
  end

  def show
    @likes = Like.all
    @users = User.all
    @tweets = Tweet.all.order('created_at DESC')
    if current_user
      @tweet = current_user.tweets.new
      @not_followed = User.all.order('created_at DESC') - current_user.followed_users
      @not_followed.delete(current_user)
      @followed_and_user_tweets = @tweets.where(author_id:current_user.followed_users.pluck(:id))
    end
  end

  def new
    @tweet = current_user.tweets.build

  end

  def edit; end


  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to request.referrer, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to root_path, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { redirect_to request.referrer }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
