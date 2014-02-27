class Project < ActiveRecord::Base


  has_many :responsibilities, :class_name => "UsersToProjects", :dependent => :destroy
  has_many :users, :through => :responsibilities
  
  has_many :documents, :dependent => :destroy
  has_many :workspaces, :dependent => :destroy
  
  has_many :constant_relations, :as => :configurable
  
  has_many :content_types, :dependent => :destroy
  
  has_many :branches, :dependent => :destroy
  has_many :contents, :dependent => :destroy
  
  has_many :content_relation_types, :dependent => :destroy
  
  has_many :hosts, :dependent => :destroy
  accepts_nested_attributes_for :hosts, :allow_destroy => true
  
  has_many :constants, :dependent => :destroy
  accepts_nested_attributes_for :constants, :allow_destroy => true
  
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

  def base 
    base = self.hosts.primary
    
    return "#{base.protocol}#{base.host}"
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
      # puts 'Langues was changed!'
      # puts lng_before
      # puts lng_after
    end
    
  end

  def reorder_content_relation_type args = {}
  
    if crt = self.content_relation_types.where(:id => args.crt).first
      crt.position = args.position
      crt.save
    end
  end

  def constant(category)
    Constant.all.where(:project_id => self.id).where(:category => category)
  end

end
