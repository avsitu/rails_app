class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :liked_posts]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end  


  def show
    @user = User.find_by(username: params[:id])
    if @user.nil?
      redirect_to root_path
    else  
      @microposts = @user.microposts.paginate(page: params[:page])
      # render post form if current user
      @micropost = current_user.microposts.build if current_user == @user
    end  
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App #{@user.name}!
        To get started, try composing a post or check out what other users have posted."
      redirect_to user_path(@user.username)
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user.username)
    else
      render 'edit'
    end
  end  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end  

  def following
    @title = "Following"
    @user  = User.find_by(username: params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find_by(username: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def liked_posts
    @microposts = current_user.liked_posts.paginate(page: params[:page])
    render 'liked_posts'
  end  

  def search
    @users = User.where("name LIKE :query OR username LIKE :query", query: "%#{params[:q]}%")
    @users = @users.paginate(page: params[:page], per_page: 15)
    # render 'index'
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end     
  end  

  private

    def user_params
      params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end         

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user
      @user = User.find_by(username: params[:id])
      redirect_to(root_url) unless @user == current_user
    end     
end
