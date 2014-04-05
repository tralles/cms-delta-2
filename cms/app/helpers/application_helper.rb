module ApplicationHelper

  def md(buffer)
  
      return Kramdown::Document.new(buffer, :auto_ids => false).to_html.html_safe
  end

end
