class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    return unless @order.user != current_user

    redirect_to root_path, alert: 'Você não possui acesso a este pedido.'
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
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def edit
    @order = Order.find(params[:id])
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
