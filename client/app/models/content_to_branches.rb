class ContentToBranches < ActiveRecord::Base

  belongs_to :content
  belongs_to :branch

end
