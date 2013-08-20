class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :close, :edit, :update, :destroy]
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
    @content.project        = @project
    @content.content_type   = @content_type
  end
  
  def close
    @content.user = nil
    @content.save
    
    redirect_to project_content_type_contents_path(@project, @content_type)
  end

  # GET /contents/1/edit
  def edit
    @content.user = current_user
    @content.save
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(permitted_params.content)
    
    @content.project        = @project
    @content.content_type   = @content_type

    respond_to do |format|
      if @content.save
      
        if params[:content_elements][:add]
          params[:content_elements][:add].each do |content_element_type, value|
            @content.content_elements.build(:content_element_type_id => content_element_type, :language => @locale, :value => value).save
          end
        end
        @content.proof_bracketcommands
      
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
      if @content.update(permitted_params.content)
      
        
        @content.user = nil
        @content.save
      
        if params[:content_elements][:add]
          params[:content_elements][:add].each do |content_element_type, value|
            @content.content_elements.build(:content_element_type_id => content_element_type, :language => locale, :value => value).save
          end
        end


        if params[:content_elements][:update]
          params[:content_elements][:update].each do |content_element_id, value|
            ce = @content.content_elements.where('content_elements.id = ?', content_element_id).first
            ce.value = value
            ce.save
          end
        end
        
        @content.proof_bracketcommands
      
        format.html { redirect_to project_content_type_content_path(@project, @content_type, @content, :locale => @locale), notice: 'Content was successfully updated.' }
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
      format.html { redirect_to project_content_type_contents_path(@project, @content_type) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end
  
    def set_project
      @project        = Project.find(params[:project_id])
      @branches       = @project.branches

      if params[:content_type_id]
        @content_type = ContentType.find(params[:content_type_id]) 
        @contents     = @content_type.contents
        # puts 'content_type_id'
        # puts @contents
      end
      
      if params[:branch]
        @branch       = @project.branches.where('branches.id = ?', params[:branch]).first 
        @contents     = (@content_type) ? @branch.contents.where(:content_type => @content_type) : @branch.contents
        # puts 'branch'
        # puts @contents
      else
        @contents     = @project.contents unless @contents
      end
      
    end


end
