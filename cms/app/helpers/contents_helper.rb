module ContentsHelper



  def cetform content, content_element_type

      value = ''
      identifier = "content_elements[add][#{content_element_type.id}]"
      
      ce = content.value(content_element_type.id, @locale)
      if ce 
        identifier = "content_elements[update][#{ce.id}]"
        value = ce.value
      end
  

    case content_element_type.simple_form
      when 'text'
        text_area_tag identifier, value, :rows => content_element_type.rows, :class => 'input-block-level'
      else
        text_field_tag identifier, value, :class => 'input-block-level'
    end
  
  end



end
