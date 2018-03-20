class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    redirect_to root_path
  end  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      flash[:danger] = "Post cannot be blank."
      redirect_to root_path
    end
  end

  def create2
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
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end  
end
