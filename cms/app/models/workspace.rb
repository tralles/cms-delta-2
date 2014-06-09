class Workspace < ActiveRecord::Base

  belongs_to :project

  has_many :workspaceables, :dependent => :destroy

  before_destroy :removePermissions




  def removePermissions
    Permission.where(:subject_class => 'Workspace').where(:subject_id => self.id).destroy_all
  end

end
