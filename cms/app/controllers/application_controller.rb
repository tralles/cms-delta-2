class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_filter :set_start_time
  before_filter :init_project

  
  def dashboard
    redirect_to new_session_path('user') unless current_user
  
  end
  
  
  
  
  
  def search 
    @contents = Content.where(:project_id => params[:project_id]).joins(:content_elements).where('content_elements.value LIKE ?', "%#{params[:query]}%").group('contents.id')
    puts @contents
  end
  
  
  
  
  
  
  
  
  # strong_attributes  
  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  helper_method :permitted_params
  

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :login, :password, :remember_me) }
    devise_parameter_sanitizer.for(:login) { |u| u.permit(:username, :login, :password, :remember_me) }
  end  
  
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    @locale = I18n.locale
  end

  def set_start_time
    @start_time = Time.now.usec
  end
  
  def init_project
    @filter_workspaces  = []
    @project  = Project.find(params[:project_id]) if params[:project_id]
    @project  = Project.find(params[:id]) if params[:id] && controller_name == 'projects'

    if current_user && ( (@project && ( current_user.projects.include?(@project) || current_user.admin? )) || @project.nil? )

      if @project
        @workspaces = @project.workspaces.group_by &:constellation
        
        if params[:constellation]
          session[:workspace] = [] unless session[:workspace]
          session[:workspace][@project.id] = {} unless session[:workspace][@project.id]
          if params[:workspace]
            session[:workspace][@project.id][params[:constellation]] = params[:workspace].to_i
          else
            session[:workspace][@project.id][params[:constellation]] = 0
          end
          
          redirect_to url_for(params.except(:constellation, :workspace))
        end
        
        
        if session[:workspace] && session[:workspace][@project.id]
          session[:workspace][@project.id].each do |c,ws|
            @filter_workspaces << ws if ws > 0
          end
        end
      end

    else
      redirect_to root_path
    end
    
  end
  
end
