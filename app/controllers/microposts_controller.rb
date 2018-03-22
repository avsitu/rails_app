class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :create_at_profile]
  before_action :correct_user,   only: :destroy

  def index
    redirect_to root_path
  end  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to request.referrer
    else
      flash[:danger] = "Post cannot be blank."
      redirect_to request.referrer
    end
  end

  def create_at_profile
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to current_user
    else
      flash[:danger] = "Post cannot be blank."
      redirect_to current_user
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url    
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end  

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_path if @micropost.nil?
    end  
end
