class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /branches
  # GET /branches.json
  def index
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
    @branch.branch_routes.build
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(permitted_params.branch)
    @branch.project = @project
    @branch.parent = @parent if @parent

    respond_to do |format|
      if @branch.save
        format.html { redirect_to project_branches_url(@project), notice: 'Branch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @branch }
      else
        format.html { render action: 'new' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|

      if params[:parent_id]
        @parent = @project.branches.where('id = ?', params[:parent_id]).first
        if @parent
          @branch.parent = @parent 
        else
          @branch.parent = nil
        end
      end

      if @branch.update(permitted_params.branch)
        format.html { redirect_to project_branches_url(@project), notice: 'Branch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to project_branches_url(@project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end
    
    def set_project
      @project = Project.find(params[:project_id])
      @parent = nil 
      @parent = Branch.find(params[:branch_id]) if params[:branch_id]
      @branches = @project.branches
    end
    
end
