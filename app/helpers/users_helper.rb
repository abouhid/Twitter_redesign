# frozen_string_literal: true

module UsersHelper
  def current_user?(user)
    current_user == user
  end

  def not_followed(user)
    User.where.not(follower_id: user)
  end
end
