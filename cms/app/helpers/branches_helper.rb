module BranchesHelper


  def content_in_branches(branches, form = nil)
    html = ''
    
    branches.map do |branch, sub_branches|
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


    
    return html.html_safe
  
  end


  def sitemap(branches, form = nil)

#    
    html = ''
    
    branches.map do |branch, sub_branches|
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


    
    return html.html_safe
  end



  def nested_branches(branches, form = nil)

#    
    html = ''

    branches.map do |branch, sub_branches|
      html << "<li class='#{ 'disabled' if form && (branch == form.object || form.object.children.include?(branch)) }'>"

        html << render(:partial => 'branches/branch', :locals => { :branch => branch, :form => form }) 
                
        unless sub_branches.empty?
          html << '<ul class="level">'
          html << nested_branches(sub_branches, form)
          html << '</ul>'
        end

      html << '</li>' 
    end


    
    return html.html_safe
  end


end
