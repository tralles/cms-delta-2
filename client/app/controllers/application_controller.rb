class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :set_locale
  before_action :initalize




  def index
    
  end








  def initalize
    @project = Project.by_host(request.host_with_port)
    
    if @project.base == "#{request.protocol}#{request.host_with_port}"

      if params[:route]
        @route  = @project.routes.by_path(@language, '/'+params[:route])
        @route  = @route.first
      else
        @route  = @project.routes.first
        redirect_to "/#{I18n.default_locale}#{@route.route}"
      end
      
      if @route && !@route.jump.empty?
        redirect_to @route.jump
      elsif @route
        @branch     = @route.branch
        @contents   = @branch.contents
      else
        redirect_to "/#{I18n.default_locale}/"
      end
    else
    
      redirect_to "#{@project.base}#{request.fullpath}" 
    
    end
    
  end
 
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      @language = I18n.locale
    else
      redirect_to "/#{I18n.default_locale}/"
    end
  end
  
end
