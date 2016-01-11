class Document < ActiveRecord::Base


  belongs_to :project

  has_many :workspaceables, :as => :workspaceable, :dependent => :destroy
  has_many :workspaces, :through => :workspaceables

  has_many :documentables, :dependent => :destroy

  has_attached_file :document,
    :styles => {
      :thumb => ["50x50#", :png],
      :icon => ["100x100#", :png],
      :square => ["400x400#", :png],
      :preview => ["200x200>", :png],
      :normal => ["640x400>", :png],
      :popup => ["800x600>", :png]
    },
    :convert_options => {
      :all => "-strip -colorspace RGB",
    },
    :path => ":rails_root/public/uploads/:project_intern/:attachment/:id/:style/:filename",
    :url => "/uploads/:project_intern/:attachment/:id/:style/:filename"





    validates_attachment_presence :document
    validates_attachment_content_type :document, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']



    scope :finder, ->(search) { where("document_file_name LIKE ?", "%#{search}%") }
    scope :doctype, ->(doctype) { where(:doctype => doctype) unless doctype.blank? }



    after_post_process :save_dimensions

  def save_dimensions
    begin
      geo = Paperclip::Geometry.from_file(document.queued_for_write[:original])
      self.width = geo.width
      self.height = geo.height
    rescue
    end
  end





  def filetype
    self.document_content_type.split('/')[1]
  end


  def doctype_name
    if self.doctype
      self.project.constant(:doctype).where(:id => self.doctype).first.name
    end
  end

end
