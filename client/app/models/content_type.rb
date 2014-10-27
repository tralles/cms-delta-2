class ContentType < ActiveRecord::Base

  has_many :templatables, :as => :templatable, :dependent => :destroy
  has_many :templates, :through => :templatables

end
