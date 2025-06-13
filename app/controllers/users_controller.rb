class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:company_identifier] || params[:username]
      @users = User.by_company(params[:company_identifier])
                   .by_username(search_params[:username])
    else
      @users = User.all
    end
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User created successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.udate(user_params)
      redirect_to @user, notice: "User updated successfully"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_params
    params.permit(:username)
  end

  def user_params
    params.require(:user).permit(:display_name, :email, :username, :company_id)
  end

end
