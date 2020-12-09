class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'

  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :friendships_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :friend_requests, through: :friendships_requests, source: :user

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }

    friends_array.compact
  end

  def friends_and_own_posts
    ids = friends.pluck(:id)
    ids.push(id)
    Post.where(user_id: ids)
  end
end
