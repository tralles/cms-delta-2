class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :lockable, :validatable


  has_many :rights, :class_name => "CreateUsersToPermissions"
  has_many :permissions, :through => :rights
         
  has_many :responsibilities, :class_name => "UsersToProjects"
  has_many :projects, :through => :responsibilities

  validates_presence_of :name, :surname, :email



  def username
    "#{self.name} #{self.surname}"
  end

  def admin?
    return admin
  end




end
