json.array!(@templates) do |template|
  json.extract! template, :id, :project_id, :title, :code
  json.url template_url(template, format: :json)
end
