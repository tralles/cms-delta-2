class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_project, except: [:index, :new, :create]

  # GET /projects
  # GET /projects.json
  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  def css
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  def renew_cache
    @project.renew_cache
    redirect_to @project, notice: 'Cache renewed.'
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(permitted_params.project)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(permitted_params.project)

        @project.set_languages( params[:project][:languages] ) if params[:project][:languages]

        format.html {
          if params && params[:project] && params[:project][:css]
            redirect_to css_project_path(@project), notice: 'CSS was successfully updated.'
          else
            redirect_to @project, notice: 'Project was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end








  def settings
  end


  def users
  end






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project

      if !current_user.projects.include?(@project) && !current_user.admin?
        redirect_to root_path
      end
    end

end
