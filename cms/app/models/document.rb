class Document < ActiveRecord::Base


  belongs_to :project

  has_attached_file :document, 
    :styles => {
      :thumb => ["50x50#", :jpg],
      :preview => ["200x200>", :jpg],
      :normal => ["640x400>", :jpg]
    },
    :convert_options => {
      :all => "-strip -colorspace RGB",
    },
    :path => ":rails_root/public/documents/:project_intern/:attachment/:id/:style/:filename",
    :url => "/documents/:project_intern/:attachment/:id/:style/:filename"



    after_post_process :save_dimensions

  def save_dimensions
    geo = Paperclip::Geometry.from_file(document.queued_for_write[:original])
    self.width = geo.width
    self.height = geo.height
  end



end
