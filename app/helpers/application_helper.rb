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
end
