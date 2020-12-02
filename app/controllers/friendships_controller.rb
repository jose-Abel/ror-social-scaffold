class FriendshipsController < ApplicationController
	def new; end

	def create
		friendship = Friendship.new(user_id: current_user.id, friend_id: params[:format].to_i)

		current_user.pending_friends.each do |pending_friend| 
			
			if pending_friend.id == params[:format].to_i
				redirect_to users_path, alert: "You already sent a friend request to this user" and return
			end
		end

		if friendship.save
			flash[:notice] = "Your friend request has been sent!"
			redirect_to users_path
		else
			flash[:alert] = friendship.errors_full_messages
			redirect_to users_paths
		end
	end

	def edit

	end

	def update
		current_user.confirmed_friend
	end

	def show
		@user = current_user
	end

	def friends_list
		@all_friends = current_user.friends
	end

	def pending_requests
		@pending_arr = current_user.pending_friends.collect(&:name)

	end
end