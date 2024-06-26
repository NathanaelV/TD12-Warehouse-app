require 'rails_helper'

describe 'User edit order request' do
  it 'without authorization' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    shiryu = User.create!(name: 'Shiryu', email: 'shiryu@saintseiya.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    # Act
    login_as(shiryu)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    # Assert
    expect(response).to redirect_to root_path
  end
end
