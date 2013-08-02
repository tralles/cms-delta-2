module BranchesHelper


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
