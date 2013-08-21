class ContentToBranches < ActiveRecord::Base

  belongs_to :content
  belongs_to :branch
  
  
  default_scope { order('position ASC') }

end
