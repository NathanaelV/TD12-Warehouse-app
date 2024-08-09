class OrdersMailer < ApplicationMailer
  default from: 'pedidos@warehouse.app'

  def notify_new_order
    @order = params[:order]
    mail(subject: 'Novo Pedido', to: @order.supplier.email)
  end
end
