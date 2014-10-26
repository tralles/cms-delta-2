class Template < ActiveRecord::Base

  has_paper_trail :only => [:code]

  belongs_to :project
  has_many :templatables, :dependent => :destroy


  validates_presence_of :title, :code

  def parents
    parents = []
    self.templatables.each do |templatable|
      begin
        parents << templatable.templatable_type.singularize.classify.constantize.find_by_id(templatable.templatable_id)
      rescue
      end
    end
    return parents
  end


  def name
    return "<strong>#{self.title}</strong> (#{self.action})".html_safe
  end


end
