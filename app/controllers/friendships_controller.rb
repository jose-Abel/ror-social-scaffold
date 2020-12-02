class FriendshipsController < ApplicationController
	def new; end

	def create
		friendship = Friendships.new(user_id: current_user.id, friend_id: params[:friend_id])

		if friendship.save
			flash[:notice] = "Your friend request has been sent!"
			redirect_to friendships_path(params[:friend_id])
		else
			flash[:alert] = friendship.errors_full_messages
			redirect_to new_friendship_path
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
		@pending = current_user.pending_friends
	end
end