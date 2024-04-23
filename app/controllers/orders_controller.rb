class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.order(:name)
      @suppliers = Supplier.order(:corporate_name)
      flash.now[:alert] = 'Não foi possível registrar o pedido.'
      render :new
    end
  end

  def search
    @code = params[:query]
    @order = Order.find_by(code: @code)
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
