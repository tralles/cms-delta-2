class Content < ActiveRecord::Base

  has_many :content_elements, :dependent => :destroy
#  accepts_nested_attributes_for :content_elements, :allow_destroy => true



  belongs_to :project

  belongs_to :user

  belongs_to :content_type

  has_many :content_elements, :dependent => :destroy

  has_many :ctbs, :class_name => "ContentToBranches", :dependent => :destroy
  has_many :branches, :through => :ctbs




  def value content_element_type, language
    self.content_elements.where('content_elements.content_element_type_id = ?', content_element_type).where('content_elements.language = ?', language).first
  end



  def rep language

    repraesentant = ''
    self.content_elements.where('content_elements.language = ?', language).each do |ce|
      repraesentant = repraesentant + ce.value if ce.content_element_type.mandatory
    end
    
    repraesentant

  end
  
  
  def languages
  
    languages = []
  
    self.content_elements.group(:language).each do |ce| 
      languages << ce.language
    end
    
    languages
  end
  
  
  
  def option(name, args = nil)
    ausgabe = nil
    
    meta = YAML::load(self.content_type.meta)

    if meta && meta.send(name.to_sym)
      ausgabe = meta.send(name.to_sym)
    end
      
    return ausgabe

  end
  
  
  def method_missing(name, args = nil)
    ausgabe = nil 

    ce = self.content_elements.includes(:content_element_type).where('content_element_types.intern = ?', name).references(:content_element_types)

    if @locale
      ce = ce.where('content_elements.language = ?', @locale).first
    elsif args && args[:locale]
      ce = ce.where('content_elements.language = ?', args[:locale]).first
    else
      ce = ce.first
    end

    ausgabe = ce.value if ce 

    return ausgabe
  end


end
