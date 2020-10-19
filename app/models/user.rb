class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:login]
validates :email, uniqueness: true
validates :username, presence: true, uniqueness: { case_sensitive: false }
validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

has_many :tweets, dependent: :destroy
has_many :replies, dependent: :destroy
has_many :likes, dependent: :destroy

has_many :relationships, foreign_key: "follower_id", dependent: :destroy
has_many :followed_users, through: :relationships, source: :followed

has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
has_many :followers, through: :reverse_relationships, source: :follower

def following?(other_user)
  relationships.find_by_followed_id(other_user.id)
end

def follow!(other_user)
  relationships.create!(followed_id: other_user.id)
end
def unfollow!(other_user)
  relationships.find_by_followed_id(other_user.id).destroy
end


 # Will return an array of follows for the given user instance
#  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

#  # Will return an array of users who follow the user instance
#  has_many :followers, through: :received_follows, source: :follower
 
#  #####################
 
#  # returns an array of follows a user gave to someone else
#  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
 
#  # returns an array of other users who the user has followed
#  has_many :followings, through: :given_follows, source: :followed_user

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end



end
