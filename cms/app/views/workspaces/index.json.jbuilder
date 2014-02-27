json.array!(@workspaces) do |workspace|
  json.extract! workspace, :project_id, :intern, :name
  json.url workspace_url(workspace, format: :json)
end
