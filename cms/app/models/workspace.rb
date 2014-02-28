class Workspace < ActiveRecord::Base

  belongs_to :project
  
  has_many :workspaceables, :dependent => :destroy

end
