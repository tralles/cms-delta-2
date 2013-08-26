class ContentRelationTypesController < ApplicationController
  before_action :set_content_relation_type, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /content_relation_types
  # GET /content_relation_types.json
  def index
    @content_relation_types = ContentRelationType.all
  end


  # GET /content_relation_types/new
  def new
    @content_relation_type = ContentRelationType.new
  end

  # GET /content_relation_types/1/edit
  def edit
  end

  # POST /content_relation_types
  # POST /content_relation_types.json
  def create
    @content_relation_type          = ContentRelationType.new(permitted_params.content_relation_type)
    @content_relation_type.project  = @project

    respond_to do |format|
      if @content_relation_type.save
        format.html { redirect_to project_content_relation_types_path(@content_relation_type.project), notice: 'Content relation type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @content_relation_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @content_relation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_relation_types/1
  # PATCH/PUT /content_relation_types/1.json
  def update
    respond_to do |format|
      if @content_relation_type.update(permitted_params.content_relation_type)
        format.html { redirect_to project_content_relation_types_path(@content_relation_type.project), notice: 'Content relation type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @content_relation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_relation_types/1
  # DELETE /content_relation_types/1.json
  def destroy
    @content_relation_type.destroy
    respond_to do |format|
      format.html { redirect_to content_relation_types_url }
      format.json { head :no_content }
    end
  end
  
  
  
  


  def sort
    nummer = 1
    

    params[:content_relation_type].each do |crt|
      @project.reorder_content_relation_type :crt => crt, :position => nummer
      nummer = nummer + 1
    end
    
    render json: {:success => true }
    
  end  
  
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_relation_type
      @content_relation_type = ContentRelationType.find(params[:id])
    end
    
    def set_project
      @project = Project.find(params[:project_id])
      @content_relation_types = @project.content_relation_types
    end

end
