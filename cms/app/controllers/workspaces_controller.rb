class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /workspaces
  # GET /workspaces.json
  def index
    @workspaces = @project.workspaces
  end

  # GET /workspaces/1
  # GET /workspaces/1.json
  def show
  end

  # GET /workspaces/new
  def new
    @workspace = Workspace.new
  end

  # GET /workspaces/1/edit
  def edit
  end

  # POST /workspaces
  # POST /workspaces.json
  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.project = @project

    respond_to do |format|
      if @workspace.save
        format.html { redirect_to project_workspaces_url(@project), notice: 'Workspace was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@project, @workspace] }
      else
        format.html { render action: 'new' }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspaces/1
  # PATCH/PUT /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.html { redirect_to project_workspaces_url(@project), notice: 'Workspace was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1
  # DELETE /workspaces/1.json
  def destroy
    @workspace.destroy
    respond_to do |format|
      format.html { redirect_to project_workspaces_url(@project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params[:id])
    end

    def set_project
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def workspace_params
      params.require(:workspace).permit(:constellation, :intern, :name, :content_type_ids => [])
    end
end
