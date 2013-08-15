class ContentTypesToBranch < ActiveRecord::Base

  belongs_to :content_type
  belongs_to :branch

end
