class Content < ActiveRecord::Base

  has_many :content_elements, :dependent => :destroy
#  accepts_nested_attributes_for :content_elements, :allow_destroy => true



  belongs_to :project
  belongs_to :content_type



  def rep 

    repraesentant = ''
    self.content_elements.each do |ce|
      repraesentant = repraesentant + ce.value if ce.content_element_type.mandatory
    end
    
    repraesentant

  end


end
