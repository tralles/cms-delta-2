class Project < ActiveRecord::Base


  has_many :responsibilities, :class_name => "UsersToProjects"#, :dependent => :destroy
  has_many :users, :through => :responsibilities

  has_many :documents#, :dependent => :destroy

  has_many :content_types#, :dependent => :destroy

  has_many :branches#, :dependent => :destroy
  has_many :routes, :through => :branches, :class_name => "BranchRoute"

  has_many :content_types
  has_many :contents

  has_many :content_relation_types#, :dependent => :destroy

  has_many :hosts#, :dependent => :destroy

  has_many :configurations, :as => :configurable
  has_many :constant_relations, :as => :configurable


  has_many :constants


  scope :by_host, ->(host) { joins(:hosts).where('hosts.host = ?', host).first }




  # Virtual attributes
  def languages
    languages = []

    self.constant_relations.category('languages').each do |cr|
      languages << cr.constant.value
    end

    languages
  end

  def base
    base = self.hosts.primary

    return "#{base.protocol}#{base.host}"
  end

  def constant(category)
    Constant.all.where(:project_id => self.id).where(:category => category)
  end


end
