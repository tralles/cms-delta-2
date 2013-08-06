class ContentElementTypesController < ApplicationController
  before_action :set_content_element_type, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /content_element_types
  # GET /content_element_types.json
  def index
  end

  # GET /content_element_types/1
  # GET /content_element_types/1.json
  def show
  end

  # GET /content_element_types/new
  def new
    @content_element_type = ContentElementType.new
  end

  # GET /content_element_types/1/edit
  def edit
  end

  # POST /content_element_types
  # POST /content_element_types.json
  def create
    @content_element_type = ContentElementType.new(permitted_params.content_element_type)
    
    @content_element_type.content_type = @content_type

    respond_to do |format|
      if @content_element_type.save
        format.html { redirect_to project_content_type_path(@project, @content_type), notice: 'Content element type was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@project, @content_type] }
      else
        format.html { render action: 'new' }
        format.json { render json: @content_element_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_element_types/1
  # PATCH/PUT /content_element_types/1.json
  def update
    respond_to do |format|
      if @content_element_type.update(permitted_params.content_element_type)
        format.html { redirect_to project_content_type_path(@project, @content_type), notice: 'Content element type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @content_element_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_element_types/1
  # DELETE /content_element_types/1.json
  def destroy
    @content_element_type.destroy
    respond_to do |format|
      format.html { redirect_to [@project, @content_type] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_element_type
      @content_element_type = ContentElementType.find(params[:id])
    end
    
    def set_project
      @project = Project.find(params[:project_id])
      @content_type = ContentType.find(params[:content_type_id])
      @content_element_types = @content_type.content_element_types
    end

end
