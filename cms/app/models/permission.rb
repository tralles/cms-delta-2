class Permission < ActiveRecord::Base


  belongs_to :user
  belongs_to :project
  
  scope :by_project, ->(project) { where('project_id = ?', project.id) unless project.nil? }




  def self.is_stored?(user, project, action, subject_class)
    Permission.where(:user_id => user.id,
                     :project_id => project.id,
                     :action => action,
                     :subject_class => subject_class).first
  end


end
