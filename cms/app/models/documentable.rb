class Documentable < ActiveRecord::Base


  belongs_to :project

  belongs_to :document
  belongs_to :documentable, :polymorphic => true

  accepts_nested_attributes_for :document
  
  default_scope { order('position ASC') }
  

  def parent
    begin 
      self.documentable_type.singularize.classify.constantize.find_by_id(self.documentable_id)
    rescue 
    end
  end
end
