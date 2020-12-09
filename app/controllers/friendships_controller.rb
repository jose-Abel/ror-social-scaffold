# rubocop : disable Lint/UselessAssignment

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    user = User.find_by(id: params[:format].to_i)

    friendship = Friendship.new(user_id: current_user.id, friend_id: user.id, confirmed: false)

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

    friendship = Friendship.find(params[:id].to_i)

    friendship.update_attributes(confirmed: true)

    friendship2 = Friendship.new(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)

    if friendship2.save
      flash[:notice] = 'Friend request has been accepted!'
    else
      flash[:alert] = friendship.errors_full_messages
    end

    redirect_to users_path
  end

  def show
    @user = current_user
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = 'You rejected this friendship successfully'

    redirect_to users_path
  end

  def friends_list
    @all_user = User.all
    @all_user = @all_user.reject { |x| x.id == current_user.id }
  end

  def pending_requests
    @all_user = User.all
    @all_user = @all_user.reject { |x| x.id == current_user.id }
  end

  def friends_requests
    @all_user = User.all
  end
end

# rubocop : enable Lint/UselessAssignment
