json.array!(@content_types) do |content_type|
  json.extract! content_type, :project_id, :ref_id, :name, :intern, :editor
  json.url content_type_url(content_type, format: :json)
end
