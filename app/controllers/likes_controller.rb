class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(tweet_id: params[:tweet_id])
    @tweets = Tweet.all.order('created_at DESC').includes(%i[user replies])

    if @like.save
      redirect_to request.referrer, notice: 'You liked a tweet.'
    else
      redirect_to request.referrer, alert: 'You cannot like this tweet.'
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, tweet_id: params[:tweet_id])
    if like
      like.destroy
      redirect_to request.referrer, notice: 'You disliked a tweet.'
    else
      redirect_to request.referrer, alert: 'You cannot dislike tweet that you did not like before.'
    end
  end
end
