json.array!(@contents) do |content|
  json.extract! content, :image_url, :url, :title
  json.url content_url(content, format: :json)
end
