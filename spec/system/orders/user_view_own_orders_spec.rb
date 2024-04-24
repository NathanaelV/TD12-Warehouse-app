require 'rails_helper'

describe 'User view own orders' do
  it 'must be authenticated' do
    # Arrange

    # Act
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'does not see other requests' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    second_user = User.create!(name: 'Shiryu', email: 'shiryu@saintseiya.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    first_order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    second_order = Order.create!(user: second_user, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    third_order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
end
