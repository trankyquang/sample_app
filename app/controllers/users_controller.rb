class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, except: [:new, :create, :index]

  def show
    @user_following_count = @user.following.count
    @user_followers_count = @user.followers.count
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def destroy
    @user.destroy
    flash[:success] = t "user_delete"
    redirect_to users_url
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "pls_check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def following
    @title = t "following"
    @user  = User.find params[:id]
    if @user.nil?
      render :error
    end
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = t "followers"
    @user  = User.find params[:id]
    if @user.nil?
      render :error
    end
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      render :error
    end
  end
end
