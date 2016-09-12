class UsersController < ApplicationController
  before_action :require_logged_in_user, only: [:edit,:update]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "Success_sign_up"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password,
      :password_confirmation, :gender
  end
end
