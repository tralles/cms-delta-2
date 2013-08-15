module BranchesHelper


  def breadcrump branch, trenner = '<span class="divider"><i class="icon-angle-right"></i></span>'
    
    html = ''
    
    branch.path.each do |child|
      
      route = child.route(@language)

      html << '<li>' 
      html << link_to(route.name, "/#{@language}#{route.route}")
      html << trenner
      html << '</li>' 
    end
    
    return html.html_safe
  end



  def menu( branches, nesting = true )

    branches = branches.arrange(:order => :position)

    html = ''


    branches.each do |branch, sub_branches|

      html << '<li>'

        route = branch.route(@language)
        html << link_to(route.name, "/#{@language}#{route.route}")
                
        
        if nesting
          unless branch.children.empty?
            html << '<ul class="level">'
            html << menu(branch.children, nesting)
            html << '</ul>'
          end
        end

      html << '</li>' 
    end


    
    return html.html_safe
  end


end
