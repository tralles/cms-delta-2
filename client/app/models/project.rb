class Project < ActiveRecord::Base
    
  has_many :configurations, :as => :configurable  
  has_many :constant_relations, :as => :configurable
  has_many :hosts
  
  
  has_many :content_types
  has_many :contents
  
  
  has_many :branches, :dependent => :destroy
  has_many :routes, :through => :branches, :class_name => "BranchRoute"


  has_many :documents


  scope :by_host, ->(host) { joins(:hosts).where('hosts.host = ?', host).first }


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

end
