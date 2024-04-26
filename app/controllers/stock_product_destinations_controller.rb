class StockProductDestinationsController < ApplicationController
  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = ProductModel.find(params[:product_model_id])
    stock_product = StockProduct.find_by(warehouse:, product_model:)

    return unless stock_product

    stock_product.create_stock_product_destination(stock_product_destination_params)
    redirect_to warehouse, notice: 'Item retirado com sucesso'
  end

  private

  def stock_product_destination_params
    params.permit(:recipient, :address)
  end
end
