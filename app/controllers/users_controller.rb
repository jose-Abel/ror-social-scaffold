class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user.friends.include?(current_user)
      @posts = Post.where(user_id: @user.id)
    else
      @posts = []
    end
  end
end
