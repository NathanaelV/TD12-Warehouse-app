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

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :pending)

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    # Assert
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status: Entregue'
  end
end
