json.call(
  @region,
  :id,
  :title,
  :country,
  :currency,
  :tax
)

json.products do
  json.array! @region.products do |product|
    json.call(
      product,
      :id, :title, :description, :image_url, :price, :sku, :stock
    )
  end
end