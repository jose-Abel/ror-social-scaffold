# rubocop : disable Metrics/CyclomaticComplexity

# rubocop : disable Metrics/PerceivedComplexity

module FriendshipHelper
  def friendship_check(user, friend)
    friendship_status1 = Friendship.find { |fship| fship.friend_id == user.id && fship.user_id == friend.id }
    friendship_status2 = Friendship.find { |fship| fship.user_id == user.id && fship.friend_id == friend.id }

    return 'send_invite' if friendship_status1.nil? && friendship_status2.nil?
    return 'pending' if friendship_status1.nil? && friendship_status2.confirmed == false
    return ['Accept_reject', friendship_status1] if friendship_status1.confirmed == false && friendship_status2.nil?
    return 'friends' if friendship_status1.confirmed == true && friendship_status2.confirmed == true
  end
end

# rubocop : enable Metrics/PerceivedComplexity

# rubocop : enable Metrics/CyclomaticComplexity
