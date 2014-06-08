class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

    before_action :set_project
    skip_before_filter :verify_authenticity_token, :only => [:create]

  # GET /templates
  # GET /templates.json
  def index
    @templates = @project.templates.all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)

    @template.project = @project

    respond_to do |format|
      if @template.save
        format.html { redirect_to edit_project_template_path(@template.project, @template), notice: 'Template was successfully created.' }
        format.json { render action: 'show', status: :created, location: @template }
      else
        format.html { render action: 'new' }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to edit_project_template_path(@template.project, @template), notice: 'Template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id]) if params[:project_id]
      @project = @template.project if @template && !@project
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:project_id, :title, :code, :action)
    end
end
