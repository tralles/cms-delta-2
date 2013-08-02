class BranchRoute < ActiveRecord::Base

  belongs_to :language
  belongs_to :branch

  validates_presence_of :name
  
  before_save :build_path




private

  def build_path
    if self.route
      self.route = URI::escape self.route
    else
      self.route = URI::escape self.name
    end
    
    puts self
  end


end
