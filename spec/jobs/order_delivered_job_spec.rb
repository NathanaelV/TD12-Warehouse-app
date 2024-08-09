require 'rails_helper'

RSpec.describe OrderDeliveredJob, type: :job do
  it 'should create stock products' do
    # Arrange
    user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75,
                                         sku: 'CAR-GAMER-1234')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :pending)

    OrderItem.create!(order:, product_model:, quantity: 5)

    # Act
    OrderDeliveredJob.perform_now(order)

    # Assert
    stock = StockProduct.where(product_model:, warehouse:).count
    expect(stock).to eq 5
    expect(Order.last).to be_delivered
  end

  it 'should not create stock products' do
    # Arrange
    user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75,
                                         sku: 'CAR-GAMER-1234')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :pending)

    OrderItem.create!(order:, product_model:, quantity: 5)

    order.delivered!

    # Act
    OrderDeliveredJob.perform_now(order)

    # Assert
    stock = StockProduct.where(product_model:, warehouse:).count
    expect(stock).to eq 0
  end
end
