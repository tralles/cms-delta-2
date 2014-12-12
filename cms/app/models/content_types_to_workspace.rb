class ContentTypesToWorkspace < ActiveRecord::Base

  belongs_to :content_type
  belongs_to :workspace

  scope :content_type, -> { where(:content_type => content_type) }
  
end
