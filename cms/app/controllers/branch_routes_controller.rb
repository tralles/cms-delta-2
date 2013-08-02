class BranchRoutesController < ApplicationController
  before_action :set_branch_route, only: [:show, :edit, :update, :destroy]

  # GET /branch_routes
  # GET /branch_routes.json
  def index
    @branch_routes = BranchRoute.all
  end

  # GET /branch_routes/1
  # GET /branch_routes/1.json
  def show
  end

  # GET /branch_routes/new
  def new
    @branch_route = BranchRoute.new
  end

  # GET /branch_routes/1/edit
  def edit
  end

  # POST /branch_routes
  # POST /branch_routes.json
  def create
    @branch_route = BranchRoute.new(permitted_params.branch_route)

    respond_to do |format|
      if @branch_route.save
        format.html { redirect_to @branch_route, notice: 'Branch route was successfully created.' }
        format.json { render action: 'show', status: :created, location: @branch_route }
      else
        format.html { render action: 'new' }
        format.json { render json: @branch_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branch_routes/1
  # PATCH/PUT /branch_routes/1.json
  def update
    respond_to do |format|
      if @branch_route.update(permitted_params.branch_route)
        format.html { redirect_to @branch_route, notice: 'Branch route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @branch_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branch_routes/1
  # DELETE /branch_routes/1.json
  def destroy
    @branch_route.destroy
    respond_to do |format|
      format.html { redirect_to branch_routes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch_route
      @branch_route = BranchRoute.find(params[:id])
    end

end
