class Branch < ActiveRecord::Base

  has_ancestry

  belongs_to :project
  #belongs_to :parent, :class_name => 'Branch'

  has_many :branch_routes, :dependent => :destroy
  accepts_nested_attributes_for :branch_routes, :allow_destroy => true


  has_many :cttb, :class_name => "ContentTypesToBranch", :dependent => :destroy
  has_many :content_types, :through => :cttb


  has_many :ctbs, :class_name => "ContentToBranches", :dependent => :destroy
  has_many :contents, :through => :ctbs


  has_many :templatables, :as => :templatable, :dependent => :destroy
  has_many :templates, :through => :templatables


  validates_associated :branch_routes


  before_destroy :cleanup
  after_save :renewpath


  default_scope { order('position ASC') }



  def route language
    if route = self.branch_routes.where(:language => language).first
      return route
    elsif route = self.branch_routes.first
      return route
    else
      return nil?
    end
  end




  def reorder args = {}

    ctbs = self.ctbs.where(:content_id => args[:content]).first
    ctbs.position = args[:position]
    ctbs.save

  end



private

  def cleanup

  end

  def renewpath
    self.branch_routes.each do |route|
      route.save
    end
  end


end
