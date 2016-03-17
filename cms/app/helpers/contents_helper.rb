module ContentsHelper



  def cetform content, content_element_type

    ausgabe   = ''
    value     = ''
    css       = ''

    identifier = "content_elements[add][#{content_element_type.id}]"

    ce = content.value(content_element_type.id, @locale)
    if ce.try(:id)
      identifier = "content_elements[update][#{ce.try(:id)}]"
      value = ce.try(:value) || ''
        value.strip!
    end

    css << ' inline_documents' if content_element_type.inline_documents
    css << ' required' if content_element_type.mandatory

    case content_element_type.simple_form
      when 'ContentType'

        content_type = @project.content_types.where(:intern => content_element_type.intern).first
        collection = []

        meta = YAML::load(content_element_type.meta)
        if meta && meta.constrains
          # Nur Inhalte mit gleichen Vater-Inhalt


        if @content_relation_type
          # neuen Inhalt
          content.content_relations.where(:content_relation_type_id => content.content_relation_types(content_element_type.intern).first.id).each do |cnt|
            collection << [cnt.relative.rep(@locale), cnt.relative.id]
          end
        else
          # Inhalt bearbeiten

        end

        else
          content_type.contents.each do |cnt|
            collection << [cnt.rep(@locale), cnt.id]
          end
        end

        ausgabe = select_tag identifier, options_for_select(collection, value), :include_blank => true, :class => "input-block-level#{css}"


      when 'Constant'

        constant = @project.constants.where(:name => content_element_type.intern).first
        collection = []
        unless constant.value.blank?
          liste = eval constant.value
          collection = liste[@locale.to_s]
        end

        if collection && !collection.empty?
          ausgabe = select_tag identifier, options_for_select(collection, value), :include_blank => true, :class => "input-block-level#{css}"
        end

      when 'textarea'
        css << ' redactor' if content_element_type.wysiwyg
        css << ' html' if content_element_type.html
        css << ' html' if content_element_type.haml
        css << ' markdown' if content_element_type.markdown
        css << ' autosize' if content_element_type.autosize
        ausgabe = text_area_tag identifier, value, :rows => content_element_type.rows, :class => "input-block-level#{css}"


      when 'boolean'
        ausgabe = ausgabe + hidden_field_tag( identifier, 'false')
        ausgabe = ausgabe + check_box_tag( identifier, 'true', ((value.blank? || value == 'false') ? false : true) )
        ausgabe = raw ausgabe


      when 'date'
        ausgabe = raw "<div class='input-append date' data-date='#{value}' data-date-format='dd-mm-yyyy'>#{ text_field_tag identifier, value, :class =>  "span2 datepicker#{css}" }<span class='add-on muted'>#{Time.zone.now.to_date}</span></div>"


      when 'time'
        ausgabe = raw "<div class='input-append time'>#{ text_field_tag identifier, value, :class =>  "span2 timepicker#{css}" }<span class='add-on muted'>#{Time.zone.now.strftime('%H:%M')}</span></div>"

      when 'date_time'
        ausgabe = text_field_tag identifier, value, :class =>  "input-block-level datetimepicker", 'data-format'=>"yyyy-MM-dd hh:mm", 'data-date'=>"#{value}"

      else
        ausgabe = text_field_tag( identifier, value, :class =>  "input-block-level")


    end


    return ausgabe
  end



end
