class ContentRelation < ActiveRecord::Base

  belongs_to :project
  belongs_to :content
  belongs_to :relative, :class_name => "Content"
  
  belongs_to :content_relation_type
  
  
  
  scope :by_content_relation_type, ->(crt) { includes(:content_relation_type).where('content_relation_types.intern = ?', crt) unless crt.nil? }

end
