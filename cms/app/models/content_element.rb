class ContentElement < ActiveRecord::Base

  belongs_to :content
  belongs_to :content_element_type
  
  
  scope :lang, ->(lang) { where(:language => lang) unless lang.nil? }
  
  
  validates_presence_of :value

end
