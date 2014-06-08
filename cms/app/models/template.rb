class Template < ActiveRecord::Base

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



end
