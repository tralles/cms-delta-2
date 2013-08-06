class ContentElementType < ActiveRecord::Base

  belongs_to :content_type
  has_many :content_elements, :dependent => :destroy
  
  validates_presence_of :name, :intern
  
  
  def simple_form 
    if self.field_type == 2
      'text'
    else
      'string'
    end 
  end
  
  
  
  
  def method_missing(name, args = nil)
    ausgabe = nil 

    meta = YAML::load(self.meta)

    if meta && meta.send(name.to_sym)
      ausgabe = meta.send(name.to_sym)
    else
      ausgabe = 2 if name == 'rows'
    end
      
    return ausgabe

  end

end
