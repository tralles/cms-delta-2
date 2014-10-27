class ContentToBranches < ActiveRecord::Base

  belongs_to :content
  belongs_to :branch


  scope :link, -> { where(:link => true) }
  default_scope { order('position ASC') }

end
