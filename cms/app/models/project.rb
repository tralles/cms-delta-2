class Project < ActiveRecord::Base


  has_many :responsibilities, :class_name => "UsersToProjects", :dependent => :destroy
  has_many :users, :through => :responsibilities
  
  
  has_many :constant_relations, :as => :configurable
  
  has_many :content_types, :dependent => :destroy
  
  has_many :branches, :dependent => :destroy
  has_many :contents, :dependent => :destroy
  
  validates_presence_of :name, :description
  
  
  has_many :configurations, :as => :configurable



  
  
  # Virtual attributes
  
  def languages
    languages = []
    
    self.constant_relations.category('languages').each do |cr|
      languages << cr.constant.value
    end
    
    languages
  end
  
  
  
  
  
  
  ##
  
  def set_languages languages
  
    lng_before = self.languages
    
    self.constant_relations.category('languages').each do |cr|
      ConstantRelation.find(cr.id).destroy
    end
    
    languages.each do |language|
      if language
        if constant = Constant.category('languages').where(:value => language).first
          self.constant_relations.build(:constant_id => constant.id).save
        end
      end
    end
    
    
    lng_after = self.languages
    
    if lng_after != lng_before
      puts 'Langues was changed!'
      puts lng_before
      puts lng_after
    end
    
  end

end
