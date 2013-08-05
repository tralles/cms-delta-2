json.array!(@branch_routes) do |branch_route|
  json.extract! branch_route, :branch_id, :language, :name, :route, :jump
  json.url branch_route_url(branch_route, format: :json)
end
