class DocumentsController < ApplicationController

  before_action :set_project
  skip_before_filter :verify_authenticity_token, :only => [:create]


  def create
    if @project
      @document = Document.new
      @document.project = @project
      

      file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @document.document = file      
      
      if @document.save

        @document.documentables.create( :documentable_type => params[:documentable_type], :documentable_id => params[:documentable_id], :project => @project ) if params[:documentable_type] && params[:documentable_id]

        render json: {:success => true, :src => @document.document.url(:thumb)}
      else
        render json: @document.errors.to_json
      end
    end
  end
  
  
  
  def destroy
    @document = Document.find(params[:id])
    
    if @document.destroy 
      redirect_to project_documents_path(@project)
    else
      redirect_to [@document.project, @document]
    end
  end
  
  
  
  
  
  
  
  def index
    @documents = @project.documents
  end






  def sort
    nummer = 1
    
    if params[:content_id]
      @content = Content.find(params[:content_id])

      params[:document].each do |documentID|
        @content.reorder_documents :document => documentID, :position => nummer
        nummer = nummer + 1
      end
    end
    
    render json: {:success => true }
    
  end




  private
    
    def set_project
      @project = Project.find(params[:project_id])
    end
    
end
