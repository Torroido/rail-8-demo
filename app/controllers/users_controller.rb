class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  skip_before_action :require_authentication, only: [:new, :create]

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
      start_new_session_for @user
      redirect_to after_authentication_url
    else
      redirect_to new_users_path, alert: "Try another email address or password."
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
