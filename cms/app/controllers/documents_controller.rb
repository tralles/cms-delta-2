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
        render json: {:success => true, :src => @document.document.url(:thumb)}
      else
        render json: @document.errors.to_json
      end
    end
  end
  
  
  
  def index
    @documents = @project.documents
  end


  private
    
    def set_project
      @project = Project.find(params[:project_id])
    end
    
end
