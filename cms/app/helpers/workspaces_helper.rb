module WorkspacesHelper


  
  
  def get_workspace(constellation)
    ausgabe = 0

    begin
      ausgabe = session[:workspace][@project.id][constellation]
    rescue 
    end
    
    ausgabe = (ausgabe) ? ausgabe : 0
    
    return ausgabe
  end
end
