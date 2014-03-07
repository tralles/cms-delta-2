class DocumentablesController < ApplicationController

  def edit
    @documentable   = Documentable.find(params[:id])
  end


  def update
    @documentable   = Documentable.find(params[:id])
    
    if @documentable.update(permitted_params.documentable)
      @content      = @documentable.parent 
      @project      = @documentable.project
    else
      # puts @documentable.update(permitted_params.documentable)
    end
  end


end