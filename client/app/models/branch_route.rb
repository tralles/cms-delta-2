class BranchRoute < ActiveRecord::Base

  belongs_to :branch
  


  scope :by_path, ->(language, path) { where(:language => language).where(:route => path) }





end
