require 'rails_helper'

describe 'User add item to order' do
  it 'successfully' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth: 30, supplier:,
                                     sku: 'PROD-A123')
    product_b = ProductModel.create!(name: 'Produto B', weight: 1, width: 10, height: 20, depth: 30, supplier:,
                                     sku: 'PROD-B123')

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade',	with: 8
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'and does not see products from another supplier' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    supplier_b = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                  registration_number: '60279287182000123',
                                  full_address: 'Torre da Indústria Brasil LTDA', city: 'Teresina', state: 'PI',
                                  email: 'vendedor@spark.com.br')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    order = Order.create!(user:, warehouse:, supplier: supplier_a, estimated_delivery_date: 2.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth: 30,
                                     supplier: supplier_a, sku: 'PROD-A123')
    product_b = ProductModel.create!(name: 'Produto B', weight: 1, width: 10, height: 20, depth: 30,
                                     supplier: supplier_b, sku: 'PROD-B123')

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
