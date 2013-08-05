class Project < ActiveRecord::Base


  has_many :responsibilities, :class_name => "UsersToProjects", :dependent => :destroy
  has_many :users, :through => :responsibilities
  
  
  has_many :constant_relations, :as => :configurable
  
  has_many :content_types, :dependent => :destroy
  
  has_many :branches, :dependent => :destroy
  
  validates_presence_of :name, :description
  
  
  has_many :configurations, :as => :configurable





  
  
  # Virtual attributes
  
  def languages
    languages = []
    puts 'languages:'
    self.constant_relations.each do |cr|
      languages << cr.constant if cr.constant.category == 'languages'
    end
    
    languages
  end
  

end
