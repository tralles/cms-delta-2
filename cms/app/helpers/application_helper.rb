module ApplicationHelper


  
  
  def get_workspace(constellation)
    begin
      ausgabe = session[:workspace][@project.id][constellation]
    rescue 
      ausgabe = 0
    end
    
    return ausgabe
  end
  
end
