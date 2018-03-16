class SessionsController < ApplicationController
  def new
  end

  def create # create new session i.e. log-in a user
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in user and redirect to the user's profile.
      log_in user
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = "Invalid User or Password."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url    
  end
end
