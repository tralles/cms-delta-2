class Branch < ActiveRecord::Base

  has_ancestry

  belongs_to :project
  belongs_to :parent, :class_name => 'Branch'

  has_many :branch_routes
  has_many :routes, :class_name => "BranchRoute"


  has_many :ctbs, :class_name => "ContentToBranches" #, :order => 'position ASC'
  has_many :contents, :through => :ctbs


  has_many :templatables, :as => :templatable, :dependent => :destroy
  has_many :templates, :through => :templatables



  validates_associated :branch_routes





  def route language
    if route = self.branch_routes.where(:language => language).first
      return route
    elsif route = self.branch_routes.first
      return route
    else
      return nil
    end
  end


end
