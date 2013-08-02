json.array!(@content_element_types) do |content_element_type|
  json.extract! content_element_type, :content_type_id, :ref_id, :name, :field_type, :position, :mandatory, :badge, :meta
  json.url content_element_type_url(content_element_type, format: :json)
end
