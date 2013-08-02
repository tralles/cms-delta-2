class Project < ActiveRecord::Base


  has_many :responsibilities, :class_name => "UsersToProjects", :dependent => :destroy
  has_many :users, :through => :responsibilities
  
  
  has_many :translations, :class_name => "LanguagesToProjects", :dependent => :destroy
  has_many :languages, :through => :translations
  
  has_many :branches, :dependent => :destroy
  
  validates_presence_of :name, :description

end
