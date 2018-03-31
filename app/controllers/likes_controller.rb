class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Micropost.find_by(id: params[:post])
    current_user.liked_posts << @post 
    # redirect_to root_path
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end    
  end  

  def destroy
    @post = Like.find_by(id: params[:id]).micropost
    current_user.liked_posts.delete(@post)
    # redirect_to root_path
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end    
  end  
end
