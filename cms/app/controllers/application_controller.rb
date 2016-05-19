class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

      include CanCan::Ability

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  before_filter :init_project
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_filter :set_start_time


  def dashboard
    redirect_to new_session_path('user') unless current_user

  end





  def search
    if params[:content_type_id]
      @contents = Content.where(:project_id => params[:project_id]).by_content_types(params[:content_type_id]).joins(:content_elements).where('content_elements.value LIKE ?', "%#{params[:query]}%").group('contents.id')
    else
      @contents = Content.where(:project_id => params[:project_id]).by_content_types(@filter_content_types).joins(:content_elements).where('content_elements.value LIKE ?', "%#{params[:query]}%").group('contents.id')
    end
  end








  # strong_attributes
  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  helper_method :permitted_params


#  rescue_from CanCan::AccessDenied do |exception|
#    redirect_to root_url, :alert => exception.message
#  end


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
    if current_user || devise_controller?
      @filter_workspaces      = []
      @filter_content_types   = []
      @workspaces             = []

      @project  = Project.find(params[:project_id]) if params[:project_id]
      @project  = Project.find(params[:id]) if params[:id] && controller_name == 'projects'

      if current_user && ( (@project && ( current_user.projects.include?(@project) || current_user.admin? )) || @project.nil? )

        if @project
          workspaces               = ( current_user.workspaces(@project).empty? ) ? @project.workspaces : current_user.workspaces(@project)
          workspaces.each do |ws|
            @workspaces << ws
          end

          @workspace_constellations = workspaces.group_by &:constellation

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
      end

      if @project

        if current_user.content_types(@project).empty?
          @project.content_types.direct.each do |ct|
            @filter_content_types << ct
          end
        else
          current_user.content_types(@project).each do |ct|
            @filter_content_types << ct
          end
        end


        if current_user.admin?
          can :manage, :all
        else


          current_user.permissions.by_project(@project).each do |permission|
            #puts permission

            if permission.subject_id.nil?
              can permission.action.to_sym, permission.subject_class.to_sym
            else
              can permission.action.to_sym, permission.subject_class.to_sym, :id => permission.subject_id
            end
          end

        end


      end
    else
      redirect_to root_path
    end

  end

end
