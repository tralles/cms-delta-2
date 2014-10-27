class Templatable < ActiveRecord::Base

  belongs_to :project

  belongs_to :template
  belongs_to :templatables, :polymorphic => true

  accepts_nested_attributes_for :template






  def parent
    begin
      self.templateable_type.singularize.classify.constantize.find_by_id(self.templateable_id)
    rescue
    end
  end


end
