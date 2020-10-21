module TweetsHelper
  def custom_timeline
    friends = current_user.followed_users
    friends_tweets = []
    if friends.empty?
      friends_tweets = current_user.tweets
    else
      friends.each do |friend|
        user_finder = User.find(friend.id)
        friends_tweets = user_finder.tweets + current_user.tweets
      end
    end
    friends
  end
end
