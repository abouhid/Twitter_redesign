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

  def edit_delete_own_tweet
    if current_user?(@tweet.user)

      link_to edit_tweet_path(@tweet), class: 'level-item' do
        raw("  <span class='icon'>
        <i class='fa fa-pencil' aria-hidden='true'></i>
    </span>")
      end

      link_to @tweet, method: :delete, data: { confirm: 'Are you sure you want to delete this tweet?' }, class: 'level-item' do
        raw("  <span class='icon'>
        <i class='fa fa-trash-o' aria-hidden='true'></i>
    </span>")
      end
    end
  end
end
