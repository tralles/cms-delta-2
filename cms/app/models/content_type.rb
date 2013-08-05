class ContentType < ActiveRecord::Base


  belongs_to :project
  
  has_many :content_element_types, :dependent => :destroy
  
  has_many :contents, :dependent => :destroy
  
  
  validates_presence_of :name, :intern

end
