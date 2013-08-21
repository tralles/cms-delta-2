class UsersController < ApplicationController

  before_filter :findUser, :only => [:show, :edit, :update]

  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(permitted_params.user)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end    
    
    respond_to do |format|
      if @user.update(permitted_params.user)
        sign_in(@user, :bypass => true) if @user == current_user
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  
  
  def index 
    @users = User.all
  end
  
  
  def logout
    current_user.releaseContents
    
    sign_out current_user
    
    session[:user_id] = nil
    reset_session
    
    redirect_to root_path
  end
  
  
  
private

  def findUser
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

end
