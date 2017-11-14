class StaticPagesController < ApplicationController
  def home
    @msg = "message from controller"
  end

  def help
  end

  def about
  end  

  def contact
  end
end
