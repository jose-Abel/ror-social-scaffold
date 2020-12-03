class FriendshipsController < ApplicationController
	def new; end

	def create
		friendship = Friendship.new(user_id: current_user.id, friend_id: params[:format].to_i, confirmed: false)

		current_user.pending_friends.each do |pending_friend| 
			
			if pending_friend.id == params[:format].to_i
				redirect_to users_path, alert: "You already sent a friend request to this user" and return
			end
		end

		if current_user.id == params[:format].to_i
			redirect_to users_path, alert: "Sorry, on this app you're not able to befriend yourself" and return
		end

		if friendship.save
			flash[:notice] = "Your friend request has been sent!"
			redirect_to users_path
		else
			flash[:alert] = friendship.errors_full_messages
			redirect_to users_path
		end
	end

	def edit

	end

	def update
		user = User.find_by(id: params[:id].to_i)

		if current_user.friend?(user)
			redirect_to users_path, alert: "You two are already friends!" and return
		end
		
		current_user.confirm_friend(user)

		if current_user.friend?(user)
			flash[:notice] = "Awesome, you two are now friends!"
			redirect_to users_path
		else
			flash[:alert] = "There were some errors that didn't allow you two become friends"
			redirect_to users_path
		end
	end

	def show
		@user = current_user
	end

	def destroy
		user = User.find_by(id: params[:id].to_i)
		current_user.reject_friend(user)

		unless current_user.friend?(user)
			flash[:notice] = "You rejected this friendship successfully"
			redirect_to users_path
		else
			flash[:alert] = "There were some errors that didn't allow this rejection to go through"
			redirect_to users_path
		end
	end

	def friends_list
		@all_friends = current_user.friends
	end

	def pending_requests
		@pending = current_user.pending_friends.map { |friend| friend }
	end

	def friends_requests
		@requests = current_user.friend_requests.map { |friend| friend }
	end
end