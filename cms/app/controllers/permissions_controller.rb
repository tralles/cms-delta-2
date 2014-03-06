class PermissionsController < ApplicationController
  before_action :init_module

  def add
    permission                = Permission.new
    permission.user           = @user
    permission.project        = @project
    permission.action         = @action
    permission.subject_class  = @subject_class
    permission.subject_id     = @subject_id
    permission.save

    render :layout => false
  end

  def remove
    permission = Permission.where(:user_id => @user.id,
                                  :project_id => @project.id,
                                  :action => @action,
                                  :subject_class => @subject_class,
                                  :subject_id => @subject_id).first

    permission.destroy unless permission.blank?

    render :layout => false
  end



  def index
  end

private
  
  def init_module
    @user           = @project.users.where(:id => params[:user_id]).first
    @action         = params[:action_value]
    @subject_class  = params[:subject_class]
    @subject_id     = params[:subject_id]
  end

end