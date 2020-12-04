module UserHelper
	def are_friends?(user, pending_friend)
		!user.friend?(pending_friend)
	end

	def is_pending?(user, pending_friend)
		user.pending_friends.include?(pending_friend) 
	end

	def are_inverted_friends?(user, pending_friend)
		user.inverted_friendships.each do |pending|
			return true if pending.user_id == pending_friend.id && pending.confirmed == false
		end
		false
	end
end