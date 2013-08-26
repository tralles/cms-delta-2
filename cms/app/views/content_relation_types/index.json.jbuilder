json.array!(@content_relation_types) do |content_relation_type|
  json.extract! content_relation_type, :project_id, :name, :intern, :content_type_id, :relative_type_id, :relation_type
  json.url content_relation_type_url(content_relation_type, format: :json)
end
