class StaticPagesController < ApplicationController
  def home
    @msg = "message from controller"
    @log_in_link = '#'
  end

  def help
  end

  def about
  end  

  def contact
  end
end
