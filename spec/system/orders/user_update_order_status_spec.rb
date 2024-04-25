require 'rails_helper'

describe 'User update order status' do
  it 'order was delivered' do
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
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status: Entregue'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 5
    stock = StockProduct.where(product_model:, warehouse:).count
    expect(stock).to eq 5
  end

  it 'order was canceled' do
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
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status: Cancelado'
    expect(StockProduct.count).to eq 0
  end
end
