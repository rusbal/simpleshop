json.array! @products do |product|
  json.call(
    product,
    :id, :region_id, :title, :description, :image_url, :price, :sku, :stock
  )
end
