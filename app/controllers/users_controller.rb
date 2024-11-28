class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to root_path
    else
      redirect_to new_users_path
      flash[:notice] = "Something went wrong"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email_address, :name, :password)
  end
end
