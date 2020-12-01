class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, class_name: 'Friendship', foreign_key: :friend_id

  def friends_list
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}

    friends_array + friends.map{|friendship| friendship.user if friendship.confirmed}
    
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  def friend_requests
    friends.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  def confirm_friend(user)
    friendship = friends.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends_list.include?(user)
  end
end
