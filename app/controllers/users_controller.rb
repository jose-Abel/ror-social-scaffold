class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = if @user.friends.include?(current_user)
               Post.where(user_id: @user.id)
             else
               []
             end
  end
end
