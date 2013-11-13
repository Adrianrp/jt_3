json.array!(@products) do |product|
  json.extract! product, :image_id, :title, :description, :price, :category_id
  json.url product_url(product, format: :json)
end
