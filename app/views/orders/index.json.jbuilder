json.array!(@orders) do |order|
  json.extract! order, :name, :address, :post_nr, :city, :tlf, :email, :pay_type
  json.url order_url(order, format: :json)
end
