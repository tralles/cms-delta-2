json.array!(@contents) do |content|
  json.extract! content, :old_id, :ref_id, :project_id, :content_type_id, :alpha_datum, :omega_datum, :position, :user_id, :status
  json.url content_url(content, format: :json)
end
