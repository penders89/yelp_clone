class UsersController < ApplicationController 
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end
  
  def create
    @user = User.create(user_params)
    
    if @user && @user.save
      flash[:success] = "New user created."
      redirect_to root_path
    else
      render 'new'
    end
  
  end
  
  private
    
    def user_params
      params.require(:user).permit(:username, :password, :email) 
    end
  
end