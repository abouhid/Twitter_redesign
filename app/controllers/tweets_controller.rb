class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /tweets
  # GET /tweets.json
  def index
    @likes = Like.all
    @tweets = Tweet.all.order('created_at DESC').includes(%i[user replies])
    @users = User.order('created_at DESC').includes(%i[followed_users followers replies])
    if current_user
      @tweet = current_user.tweets.new
      @not_followed = User.all.order('created_at DESC') - current_user.followed_users
      @not_followed.delete(current_user)
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @likes = Like.all
    @users = User.all
    @tweets = Tweet.all.order('created_at DESC')
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build

    # @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit; end

  # POST /tweets
  # POST /tweets.json
  def create
    # @tweet = Tweet.new(tweet_params)
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

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
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

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
