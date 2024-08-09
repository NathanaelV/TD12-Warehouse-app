require 'rails_helper'

RSpec.describe OrdersMailer, type: :mailer do
  # e-mail: subject, to, cc, bcc, body, from, attachments
  context '#notify_new_order' do
    it 'send it to supplier email' do
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

      product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                           depth: 75, sku: 'CAR-GAMER-1234')

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :pending)

      OrderItem.create!(order:, product_model:, quantity: 5)

      # Forma antiga
      # mail = OrdersMailer.notify_new_order(order)
      mail = OrdersMailer.with(order:).notify_new_order

      expect(mail.subject).to eq 'Novo Pedido'
      expect(mail.from).to eq ['pedidos@warehouse.app']
      expect(mail.to).to eq ['contato@acme.com']
    end

    it 'contains order details' do
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

      product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                           depth: 75, sku: 'CAR-GAMER-1234')

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :pending)

      OrderItem.create!(order:, product_model:, quantity: 5)

      mail = OrdersMailer.with(order:).notify_new_order

      expect(mail.body).to include 'Novo Pedido'
      expect(mail.body).to include 'Destino: Galpão Rio'
      expect(mail.body).to include '5 x CAR-GAMER-1234'
    end
  end
end
