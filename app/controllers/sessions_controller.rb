class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:email]) 
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in."
      redirect_to root_path
    else 
      flash.now[:danger] = "Sorry we could not log you in."
      render 'new'
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end
  
end