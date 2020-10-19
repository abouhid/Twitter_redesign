module UsersHelper
    def current_user?(user)
       current_user == user ? true : false      
    end
  
    # def friend_status(user, current_user)
    #   user.friendship_requested?(current_user)
    # end
  
    # def friend_or_friendship_requested(user, current_user)
    #   current_user.friendship_requested?(user) || current_user.friend?(user) || user.friendship_requested?(current_user)
    # end
  end
  