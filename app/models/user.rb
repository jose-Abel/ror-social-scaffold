class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverted_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }

    friends_array.compact
  end

  def friend_requests
    inverted_friendships.map { |fs| fs.user unless fs.confirmed }.compact
  end

  def pending_requests
    friendships.map { |fs| fs.friend unless fs.confirmed }.compact
  end
end
