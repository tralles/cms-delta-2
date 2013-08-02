json.array!(@permissions) do |permission|
  json.extract! permission, :name, :subject_class, :subject_id, :action, :description
  json.url permission_url(permission, format: :json)
end
