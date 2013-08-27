class ContentRelation < ActiveRecord::Base

  belongs_to :project
  belongs_to :content
  belongs_to :relative, :class_name => "Content"
  
  belongs_to :content_relation_type
  
  before_destroy :cleanup
  
  
  
  scope :by_content_relation_type, ->(crt) { includes(:content_relation_type).where('content_relation_types.intern = ?', crt) unless crt.nil? }

  
  default_scope { order('content_relations.position ASC') }




  def cleanup
    self.relative.destroy
  end


end
