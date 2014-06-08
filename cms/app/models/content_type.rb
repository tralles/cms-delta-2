class ContentType < ActiveRecord::Base


  belongs_to :project


  has_many :content_element_types, :dependent => :destroy, :order => 'position ASC'


  has_many :contents, :dependent => :destroy


  has_many :turfs, :class_name => "ContentTypesToBranch", :dependent => :destroy
  has_many :branches, :through => :turfs


  has_many :content_relation_types, :dependent => :destroy
  has_many :inverse_content_relation_types, :class_name => "ContentRelationType", :foreign_key => "relative_type_id", :dependent => :destroy


  has_many :templatables, :as => :templatable, :dependent => :destroy
  has_many :templates, :through => :templatables


  validates_presence_of :name, :intern

  scope :direct, -> { where(:direct_edit => true) }




  def reorder_content_element_type args = {}

    cet = self.content_element_types.where(:id => args.cet).first

    cet.position = args.position
    cet.save

  end

end
