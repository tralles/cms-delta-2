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

        @project.contents.each do |content|
          if content.filename(@language) && content.filename(@language).downcase == request.fullpath.downcase
            @content = content
          end
        end

        if @content.nil?
          redirect_to root_path and return
        end

        params[:file]   = @file
        params[:action] = 'show'
        params[:route]  = (path - [@file]).join("/")

      end



      if params[:route]
        @route  = @project.routes.by_path(@language, '/'+params[:route])
        @route  = @route.first
      else
        @route  = @project.routes.first
        redirect_to "/#{I18n.default_locale}#{@route.route}" and return
      end

      if @route && !@route.jump.empty?
        redirect_to @route.jump and return
      elsif @route
        @branch     = @route.branch
        @contents   = @branch.contents
      else
        redirect_to "/#{I18n.default_locale}/" and return
      end
    else

      redirect_to "#{@project.base}#{request.fullpath}"  and return

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
