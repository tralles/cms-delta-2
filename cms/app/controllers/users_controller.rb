class UsersController < ApplicationController


  def edit
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
  
  
  
  def index 
    @users = User.all
  end

end
