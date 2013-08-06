class Branch < ActiveRecord::Base

  has_ancestry
  
  belongs_to :project
  belongs_to :parent, :class_name => 'Branch'
  
  has_many :branch_routes, :dependent => :destroy
  accepts_nested_attributes_for :branch_routes, :allow_destroy => true
  
  validates_associated :branch_routes

  
  before_destroy :cleanup
  
  
  
  
  
  def route language
    if route = self.branch_routes.where(:language => language).first
      return route
    elsif route = self.branch_routes.first
      return route
    else
      return nil?
    end
  end
  
  
  
  
private 

  def cleanup
  
  end
  
  
end
