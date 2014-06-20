class VersionsController < ApplicationController


  def destroy
    @version  = params[:id]

    version = Version.find(params[:id])
    version.destroy
  end

end
