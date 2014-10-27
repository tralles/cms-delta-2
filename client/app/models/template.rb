class Template < ActiveRecord::Base

  belongs_to :project
  has_many :templatables, :dependent => :destroy


  validates_presence_of :title, :code
end
