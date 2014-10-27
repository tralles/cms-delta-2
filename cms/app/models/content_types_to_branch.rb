class ContentTypesToBranch < ActiveRecord::Base

  belongs_to :content_type
  belongs_to :branch

  default_scope { order('position ASC') }
end
