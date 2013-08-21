class BranchRoute < ActiveRecord::Base

  belongs_to :branch

  validates_presence_of :name
  
  before_save :build_path
  before_save :normalize_route




private

  def build_path
    if self.route
      self.route = URI::escape self.route
    else
      self.route = URI::escape self.name
    end
  end
  
  
  
  
  def normalize_route
  
    path = self.route
    ausgabe = ''
    path.split('/').each do |chunk|
      ausgabe = ausgabe + '/' + chunk unless chunk.blank?
    end
    
    self.route = ausgabe
  end


end
