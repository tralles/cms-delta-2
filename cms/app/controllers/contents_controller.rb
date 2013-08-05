class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /contents
  # GET /contents.json
  def index
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)
    
    @content.project        = @project
    @content.content_type   = @content_type

    respond_to do |format|
      if @content.save
        format.html { redirect_to [@project, @content_type, @content], notice: 'Content was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@project, @content_type, @content] }
      else
        format.html { render action: 'new' }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to [@project, @content_type, @content], notice: 'Content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end
  
    def set_project
      @project      = Project.find(params[:project_id])
      @content_type = ContentType.find(params[:content_type_id])
      @contents     = @content_type.contents
      @branches     = @project.branches
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:old_id, :ref_id, :project_id, :content_type_id, :alpha_datum, :omega_datum, :position, :user_id, :status, :content_elements )
    end
end
