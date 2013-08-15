class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :set_project


  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
  end

  # GET /hosts/new
  def new
    @host         = Host.new
    @host.project = @project
    @host.protocol = 'http://'
  end

  # GET /hosts/1/edit
  def edit
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host         = Host.new(host_params)
    @host.project = @project

    @host.save
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
  
    @host.update(host_params)
    
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    project = @host.project
    @host.destroy
    respond_to do |format|
      format.html { redirect_to settings_project_path(project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end
    
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.require(:host).permit(:protocol, :host, :primary)
    end
end
