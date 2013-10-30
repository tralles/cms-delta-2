class DocumentsController < ApplicationController

  before_action :set_project
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def edit
    @document = Document.find(params[:id])
  end
  
  def update
    @document = Document.find(params[:id])
    
    if params[:document]
      @document.update(permitted_params.document)
    end
    redirect_to project_documents_path(@project)
  end


  def create
    if @project
      @document = Document.new
      @document.project = @project
      

      file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @document.document = file      
      
      if @document.save

        @document.documentables.create( :documentable_type => params[:documentable_type], :documentable_id => params[:documentable_id], :project => @project ) if params[:documentable_type] && params[:documentable_id] && params[:documentable_id].to_i != 0

        render json: {:success => true, :src => @document.document.url(:thumb)}
      else
        render json: @document.errors.to_json
      end
    end
  end
  
  
  
  def destroy
    @document = Document.find(params[:id])
    @documentID = @document.id
    
    if @document.destroy 
#      redirect_to project_documents_path(@project)
    else
#      redirect_to [@document.project, @document]
    end
  end
  
  
  
  
  
  
  
  def index
    @documents = @project.documents.page(params[:page])
  end


  def show
    @document = Document.find(params[:id])
  end
  
  def search 
    @documents = @project.documents.search(params[:search])
    
    if @content
      @documents = @documents - @content.documents
      @documents = Kaminari.paginate_array(@documents).page(params[:page]).per(10)
    else
      @documents = Kaminari.paginate_array(@documents).page(params[:page])
    end
    
    render :index
  end
  
  def assign
    @document     = Document.find(params[:id])
    @document.documentables.build(:project => @project, :documentable => @content).save
  end
  
  def remove 
    @document     = Document.find(params[:id])
    @content.documentables.where(:document_id => @document).destroy_all
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




  def uploaded
      @project = Project.find(params[:project_id])
      if params["documentable_type"] == "Content"
        @content = Content.find(params[:documentable_id])
      end
  
  end




  private
    
    def set_project
      @project = Project.find(params[:project_id])
      @content = Content.find(params[:content_id]) if params[:content_id]
    end
    
end
