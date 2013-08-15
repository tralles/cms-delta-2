class ContentType < ActiveRecord::Base


  belongs_to :project
  
  has_many :content_element_types, :dependent => :destroy, :order => 'position ASC'
  
  has_many :contents, :dependent => :destroy
  

  has_many :turfs, :class_name => "ContentTypesToBranch", :dependent => :destroy
  has_many :branches, :through => :turfs  
  
  
  validates_presence_of :name, :intern
  
  
  
  
  
  def reorder_content_element_type args = {}
  
    cet = self.content_element_types.where(:id => args.cet).first
    
    cet.position = args.position
    cet.save
  
  end

end
