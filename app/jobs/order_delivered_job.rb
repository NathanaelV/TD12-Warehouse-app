class OrderDeliveredJob < ApplicationJob
  queue_as :default

  def perform(order)
    return if order.delivered?

    order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(order:, product_model: item.product_model, warehouse: order.warehouse)
      end
    end

    order.delivered!
  end
end
