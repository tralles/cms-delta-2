module BranchesHelper


  def content_in_branches(branches, form = nil)
    html = ''
    
    branches.map do |branch, sub_branches|
      if !Permission.is_stored?(current_user, @project, :blocked, branch.class.name, branch.id)
        css = ( (form && (branch == form.object || form.object.children.include?(branch)) ) || ( @content_type && !branch.content_types.include?(@content_type) ) ) ? 'disabled' : 'enabled'
  
        html << "<li class='#{ css }'>"
  
  
          html << render(:partial => 'branches/branch_contents', :locals => { :branch => branch, :form => form }) 
                  
          unless sub_branches.empty?
            html << '<ul class="level">'
            html << content_in_branches(sub_branches, form)
            html << '</ul>'
          end
  
        html << '</li>' 
      end
    end


    
    return html.html_safe
  
  end


  def sitemap(branches, form = nil)

#    
    html = ''
    
    branches.map do |branch, sub_branches|
      if !Permission.is_stored?(current_user, @project, :blocked, branch.class.name, branch.id)
    
        css = ( (form && (branch == form.object || form.object.children.include?(branch)) ) || ( @content_type && !branch.content_types.include?(@content_type) ) ) ? 'disabled' : 'enabled'
  
        html << "<li class='#{ css }'>"
  
  
          html << render(:partial => 'branches/branch_sitemap', :locals => { :branch => branch, :form => form }) 
                  
          unless sub_branches.empty?
            html << '<ul class="level">'
            html << sitemap(sub_branches, form)
            html << '</ul>'
          end
  
        html << '</li>' 
      end
    end


    
    return html.html_safe
  end



  def nested_branches(branches, form = nil)

#    
    html = ''

    branches.map do |branch, sub_branches|
      if !Permission.is_stored?(current_user, @project, :blocked, branch.class.name, branch.id)

        html << "<li class='#{ 'disabled' if form && (branch == form.object || form.object.children.include?(branch)) }' id='branch_#{branch.id}'>"
  
          html << render(:partial => 'branches/branch', :locals => { :branch => branch, :form => form }) 
                  
          unless sub_branches.empty?
            html << '<ol class="level" >'
            html << nested_branches(sub_branches, form)
            html << '</ol>'
          end
  
        html << '</li>' 
      end
  
    end
    
    return html.html_safe
  end


end
