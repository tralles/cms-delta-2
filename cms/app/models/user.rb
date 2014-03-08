class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :lockable, :validatable


  has_many :permissions, :dependent => :destroy
         
  has_many :responsibilities, :class_name => "UsersToProjects"
  has_many :projects, :through => :responsibilities

  validates_presence_of :name, :surname, :email

  has_many :contents


  def username
    "#{self.name} #{self.surname}"
  end

  def admin?
    return admin
  end
  
  
  
  def can_view_content?(content)
  
    ausgabe = false
  
    if content.branches.empty?
      ausgabe = true
    else
      content.branches.each do |branch|
        ausgabe = self.visible_path?(branch)
      end
    end
  
    return ausgabe
  end
  
  
  def visible_path?(branch)
    ausgabe = false

    path = branch.path.reverse
    atleastoneinpathisblocked = false
    unless path.empty?
      path.each do |parent_branch|
        if Permission.is_stored?(self, branch.project, :blocked, parent_branch.class.name, parent_branch.id)
          atleastoneinpathisblocked = true
        end
      end
      
      ausgabe = (atleastoneinpathisblocked) ? false : true
      
    else
      ausgabe = true
    end
  
    return ausgabe

  end
  
  
  
  
  
  def workspaces(project)
    workspaces = []
    self.permissions.where(:project_id => project).where(:subject_class => 'Workspace').where(:action => :read).each do |ws|
      workspaces << project.workspaces.where(:id => ws.subject_id).first
    end
    
    return workspaces
  end
  
  def content_types(project)
    content_types = []
    self.permissions.where(:project_id => project).where(:subject_class => 'ContentType').where(:action => :read).each do |ct|
      content_types << project.content_types.direct.where(:id => ct.subject_id).first
    end
    
    return content_types
  end
  
  
  
  def releaseContents
  
    self.contents.each do |content|
      content.user = nil 
      content.save
    end
  end




end
