class ContentRelationType < ActiveRecord::Base

  belongs_to :project

  
  belongs_to :content_type
  belongs_to :relative_type, :class_name => "ContentType"
  
  
  validates_presence_of :name, :intern, :content_type_id, :relative_type_id, :relation_type
  
  default_scope { order('position ASC') }
  
end
