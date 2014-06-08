class TemplatablesController < ApplicationController

  before_action :set_parent
  before_action :set_templatable, :except => [:new, :create]

  def new
    @templatable = Templatable.new

    @templatable.project          = @project
    @templatable.templatable_type = params[:templatable_type]
    @templatable.templatable_id   = params[:templatable_id]

  end


  def create
    @templatable = Templatable.new(templatable_params)

    @templatable.project          = @project
    @templatable.templatable_type = params[:templatable_type]
    @templatable.templatable_id   = params[:templatable_id]

    if @templatable.save
    else
      flash[:error] = 'Fehler'
    end
  end


  def destroy
    @templatable.destroy
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_templatable
      @templatable = Templatable.find(params[:id])
    end

    def set_parent

      if @templatable
        @parent = @templatable.parent
      elsif params[:project_id]
        @parent = Project.find(params[:project_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def templatable_params
      params.require(:templatable).permit(:template_id)
    end

end
