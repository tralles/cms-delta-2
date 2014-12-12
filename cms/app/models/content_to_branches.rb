class ContentToBranches < ActiveRecord::Base

  #acts_as_list scope: :branch

  belongs_to :content
  belongs_to :branch

  scope :link, -> { where(:link => true) }

  default_scope { order('position ASC') }

end
