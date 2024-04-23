require 'rails_helper'

describe 'User search order' do
  it 'must to be authenticated' do
    # Arrange

    # Act
    visit root_path

    # Assert
    within('header nav') do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'from homepage' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'find one order' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: order.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultado da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: SDU - Galpão Rio'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
  end

  it 'finds multiple orders' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado para cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                         address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user:, warehouse: first_warehouse, supplier:, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU09876')
    order = Order.create!(user:, warehouse: first_warehouse, supplier:, estimated_delivery_date: 2.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00700')
    order = Order.create!(user:, warehouse: second_warehouse, supplier:, estimated_delivery_date: 2.day.from_now)

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: 'GRU'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'GRU12345'
    expect(page).to have_content 'GRU09876'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).not_to have_content 'SDU00700'
    expect(page).not_to have_content 'Galpão Destino: SDU - Galpão Rio'
  end

  it 'there is no order registered' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: 'GRU'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Nenhum pedido encotrado.'
  end
end
