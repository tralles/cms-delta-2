class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :lockable, :validatable


  has_many :rights, :class_name => "UsersToPermissions"
  has_many :permissions, :through => :rights
         
  has_many :responsibilities, :class_name => "UsersToProjects"
  has_many :projects, :through => :responsibilities

  has_many :workspaceables, :as => :workspaceable, :dependent => :destroy
  has_many :workspaces, :through => :workspaceables

  validates_presence_of :name, :surname, :email

  has_many :contents


  def username
    "#{self.name} #{self.surname}"
  end

  def admin?
    return admin
  end
  
  
  
  
  
  
  def releaseContents
  
    self.contents.each do |content|
      content.user = nil 
      content.save
    end
  end




end
