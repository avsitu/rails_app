class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    current_user.liked_posts << Micropost.find_by(id: params[:post])
    redirect_to root_path
  end  

  def destroy
    post = Like.find_by(id: params[:id]).micropost
    current_user.liked_posts.delete(post)
    redirect_to root_path
  end  
end
