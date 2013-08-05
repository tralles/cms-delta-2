json.array!(@constants) do |constant|
  json.extract! constant, :category, :name, :value, :type
  json.url constant_url(constant, format: :json)
end
