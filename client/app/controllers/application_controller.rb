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



      if params[:format].present?

        path            = ("#{params[:route]}").split('/')
        @file           = path.last
        @content        = @project.contents.by_filename(@file)
        params[:file]   = @file
        params[:action] = 'show'
        params[:route]  = (path - [@file]).join("/")

      end


#      if params[:format].present?
#        params[:format] = 'htm' if params[:format] == "html"
#        @path = ("#{params[:route]}.#{params[:format]}").split('/')
#        @file  = @path.pop
#        @file_name, @file_extension = @file.split('.',2)
#        @action = @file == STANDARD_FILE ? "index" : "show"
#      else
#        @path = params[:route].split('/')
#        @file  = STANDARD_FILE
#        @file_name, @file_extension = @file.split('.',2)
#        @action = "index"
#      end
#      @params = params



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
      @locale = @language
    else
      redirect_to "/#{I18n.default_locale}/"
    end
  end
  
end
