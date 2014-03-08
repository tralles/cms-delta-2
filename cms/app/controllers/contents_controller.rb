class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :close, :edit, :update, :destroy]
  before_action :set_project
  before_action :set_hidden_ressources, only: [:update]

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
    
    @crt = params[:crt]
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
            begin
              @content.content_elements.build(:content_element_type_id => content_element_type, :language => @locale, :value => value).save
            rescue 
              flash[:error] = t('fehler.ascii')
              @content.content_elements.build(:content_element_type_id => content_element_type, :language => @locale, :value => cleanup(value)).save
            end
          end
        end
        @content.proof_bracketcommands
      
        format.html { redirect_to edit_project_content_type_content_path(@project, @content_type, @content, :locale => @locale), notice: 'Content was successfully created.' }
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
    
    @content_relation_type = @project.content_relation_types.where(:intern => params[:crt]).first if params[:crt]
    
    respond_to do |format|
      if @content.update(permitted_params.content)
      
        
        @content.user = nil
        @content.save
      
        if params[:content_elements][:add]
          params[:content_elements][:add].each do |content_element_type, value|
            begin
              @content.content_elements.build(:content_element_type_id => content_element_type, :language => locale, :value => value).save
            rescue
              flash[:error] = t('fehler.ascii')
              @content.content_elements.build(:content_element_type_id => content_element_type, :language => locale, :value => cleanup(value)).save
            end
          end
        end


        if params[:content_elements][:update]
          params[:content_elements][:update].each do |content_element_id, value|
            ce = @content.content_elements.where('content_elements.id = ?', content_element_id).first
            
            begin 
              ce.value = value
              ce.save
            rescue 
              flash[:error] = t('fehler.ascii')
              ce.value = cleanup(value)
              ce.save
            end
          end
        end
        
        @content.proof_bracketcommands
      
        format.html { redirect_to project_content_type_content_path(@project, @content_type, @content, :locale => @locale), notice: 'Content was successfully updated.' }
        format.js {}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js {}
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
      @branches       = @project.branches

      if params[:content_type_id]
        @content_type = ContentType.find(params[:content_type_id]) 
        @contents     = @content_type.contents.direct.by_content_types(@filter_content_types).by_workspace(@filter_workspaces).in_workspaces(@workspaces)
        # puts 'content_type_id'
        puts @contents
      end
      
      if params[:branch]
        @branch       = @project.branches.where('branches.id = ?', params[:branch]).first 
        @contents     = (@content_type) ? @branch.contents.direct.by_content_types(@filter_content_types).by_workspace(@filter_workspaces).in_workspaces(@workspaces).where(:content_type => @content_type) : @branch.contents
        # puts 'branch'
        # puts @contents
      else
        @contents     = @project.contents.direct.by_content_types(@filter_content_types).by_workspace(@filter_workspaces).in_workspaces(@workspaces) unless @contents
      end
      
    end
    
    
    def set_hidden_ressources
      # prevent blocked paths from beeing removed even if the user can not set the path directly
      @content.branches.each do |branch|
        params[:content][:branch_ids] << branch.id if !params[:content][:branch_ids].include?(branch.id) && !current_user.visible_path?(branch)
      end
      
      # prevent workspaces from beeing removed even it the user can not set directly
      @content.workspaces.each do |workspace|
        params[:content][:workspace_ids] << workspace.id if !params[:content][:workspace_ids].include?(workspace.id) && (!current_user.workspaces(@project).empty? && !current_user.workspaces(@project).include?(workspace))
      end
    end


    def cleanup(input)
     encoding_options = {
        :invalid           => :replace,  # Replace invalid byte sequences
        :undef             => :replace,  # Replace anything not defined in ASCII
        :replace           => '[?]',        # Use a blank for those replacements
        :universal_newline => true       # Always break lines with \n
      }
      input = input.encode Encoding.find('ISO-8859-1'), encoding_options
      
      return input
    end


end
