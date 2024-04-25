class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @products = ProductModel.all
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(order_item_params)
    @order_item.order = @order
    @order_item.save

    redirect_to @order, notice: 'Item adicionado com sucesso'
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end
end
