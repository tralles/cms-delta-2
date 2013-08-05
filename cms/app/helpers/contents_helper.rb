module ContentsHelper



  def cetform content, content_element_type
  

    case content_element_type.simple_form
      
      
      when 'text'
        text_area_tag "content_element[#{content_element_type.id}]", '', :rows => content_element_type.rows, :class => 'input-block-level'
      else
        text_field_tag "content_element[#{content_element_type.id}]", '', :class => 'input-block-level'
    end
  
  end



end
