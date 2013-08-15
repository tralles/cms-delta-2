class Host < ActiveRecord::Base

  belongs_to :project
  
  after_save :check_primary
  
  scope :primary, -> { where(:primary => 1).first }
  
  
  
  private 
  
  
    def check_primary
    
      if self.primary 
        self.project.hosts.each do |host|
          if host != self && host.primary
            host.primary = false
            host.save
          end
        end
      end
    end
  

end
