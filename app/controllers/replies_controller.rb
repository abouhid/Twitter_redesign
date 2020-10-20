# frozen_string_literal: true

class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @reply.tweet_id = params[:tweet_id]
    @reply.user = current_user
    @user_name = current_user.name

    if @reply.save
      redirect_to request.referrer, notice: 'reply was successfully created.'
    else
      redirect_to request.referrer, alert: @reply.errors.full_messages.join('. ').to_s
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
