class ContentRelation < ActiveRecord::Base

  belongs_to :project
  belongs_to :content, :class_name => "Content"
  belongs_to :relative, :class_name => "Content"
  belongs_to :binder, :class_name => "Content"

  belongs_to :content_relation_type

  before_destroy :cleanup



<<<<<<< master
  scope :by_content_relation_type, ->(crt) { includes(:content_relation_type).where('content_relation_types.intern = ?', crt) unless crt.nil? }

=======
  scope :by_content_relation_type, ->(crt) { includes(:content_relation_type).references(:content_relation_type).where('content_relation_types.intern = ?', crt) unless crt.nil? }
  scope :by_crt_and_content_and_binder, ->(content_relation_type, content, binder) { where(:content_relation_type => content_relation_type).where(:content => content).where(:binder => binder) }
>>>>>>> local

  default_scope { order('content_relations.position ASC') }




  def cleanup
    self.relative.destroy if self.relative && !self.relative.content_type.direct_edit
  end


end
