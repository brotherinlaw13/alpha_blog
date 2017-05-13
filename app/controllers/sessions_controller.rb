class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have succesfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login details"
      render 'new'

    end
  end

  def destroy
    if session[:user_id] != nil
      session[:user_id] = nil
      flash[:success] = "You have logged out"
      redirect_to root_path
    else
      flash.now[:danger] = "You are not logged in"
      render 'pages/home'
    end
  end


end