class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @reply.tweet_id = params[:tweet_id]
    @reply.user = current_user

    if @reply.save
      redirect_to tweets_path, notice: 'reply was successfully created.'
    else
      redirect_to tweets_path, alert: @reply.errors.full_messages.join('. ').to_s
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
