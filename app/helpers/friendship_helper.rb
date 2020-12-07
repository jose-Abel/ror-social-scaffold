module FriendshipHelper
  # def friend_nil?(friend)
  #   friend.nil?
  # end

  def friendship_check(user, friend) # user = current_user
    friendship_status1 = Friendship.find { |fship| fship.friend_id == user.id && fship.user_id == friend.id }
    friendship_status2 = Friendship.find { |fship| fship.user_id == user.id && fship.friend_id == friend.id }

    # byebug
    return 'send_invit' if friendship_status1.nil? && friendship_status2.nil?
    return 'pending' if friendship_status1.nil? && friendship_status2.confirmed == false
    return ['Accecp_reject', friendship_status1] if friendship_status1.confirmed == false && friendship_status2.nil?
    return 'friends' if friendship_status1.confirmed == true && friendship_status2.confirmed == true

    friendship_status1
  end
end
