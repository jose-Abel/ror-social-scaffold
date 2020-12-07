# rubocop : disable Metrics/PerceivedComplexity
# rubocop : disable Metrics/CyclomaticComplexity
# rubocop : disable Lint/NonLocalExitFromIterator

class FriendshipsController < ApplicationController
  def new; end

  def create
    user = User.find_by(id: params[:format].to_i)

    friendship = Friendship.new(user_id: current_user.id, friend_id: user.id, confirmed: false)

    # redirect_to users_path, alert: 'You two are already friends!' and return if current_user.friend?(user)

    # current_user.pending_friends.each do |pending_friend|
    #   next if pending_friend.nil?
    #   next unless pending_friend.id == user.id

    #   redirect_to users_path, alert: 'You already sent a friend request to this user' and return
    # end

    if current_user.id == user.id
      redirect_to users_path, alert: "Sorry, on this app you're not able to befriend yourself" and return
    end

    if friendship.save
      flash[:notice] = 'Your friendship request has been sent!'
    else
      flash[:alert] = friendship.errors_full_messages
    end

    redirect_to users_path
  end

  def edit; end

  def update
    user = User.find_by(id: params[:id].to_i)

    #redirect_to users_path, alert: 'You two are already friends!' and return if current_user.friend?(user)

    #current_user.confirm_friend(user)
    #friendship = Friendship.new(user_id: current_user.id, friend_id: user.id, confirmed: true)
    friendship = Friendship.find(params[:id].to_i)
    
    friendship.update_attributes(confirmed: true)
    
    friendship_2 = Friendship.new(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
    
    if friendship_2.save
      flash[:notice] = 'Friend request has been accepted!'
    else
      flash[:alert] = friendship.errors_full_messages
    end

    # if current_user.friend?(user)
    #   flash[:notice] = 'Awesome, you two are now friends!'
    # else
    #   flash[:alert] = "There were some errors that didn't allow you two become friends"
    # end
    #byebug

    redirect_to users_path
  end

  def show
    @user = current_user
  end

  def destroy
    user = User.find_by(id: params[:id].to_i)
    current_user.reject_friend(user)

    if current_user.friend?(user)
      flash[:alert] = "There were some errors that didn't allow this rejection to go through"
    else
      flash[:notice] = 'You rejected this friendship successfully'
    end

    redirect_to users_path
  end

  def friends_list
    #@all_friends = current_user.friends
    @all_user = User.all
  end

  def pending_requests
    #@pending = current_user.pending_friends.map { |friend| friend }
    @all_user = User.all
  end

  def friends_requests
    #@requests = current_user.friend_requests.map { |friend| friend }
    @all_user = User.all
  end
end

# rubocop : enable Metrics/PerceivedComplexity
# rubocop : enable Metrics/CyclomaticComplexity
# rubocop : enable Lint/NonLocalExitFromIterator
