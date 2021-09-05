json.array! @orders do |order|
  json.call(
    order,
    :shipping_address,
    :total,
    :paid_at,
    :payment_status
  )

  json.order_items do
    json.array! order.order_items do |item|
      json.call(
        item,
        :quantity, :price
      )

      json.product do
        json.call(
          item.product,
          :id, :title, :description, :image_url
        )
      end
    end
  end
end
