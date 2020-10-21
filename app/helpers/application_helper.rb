module ApplicationHelper
  def following?(other_user)
    relationships.find(other_user)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def like_or_dislike_btn(tweet)
    like = Like.find_by(tweet: tweet, user: current_user)
    if like
      link_to('👎', tweet_like_path(id: like.id, tweet_id: tweet.id), method: :delete,  class: "likes")
    else
      link_to('👍', tweet_likes_path(tweet_id: tweet.id), method: :tweet,  class: "likes")
    end
  end
end
