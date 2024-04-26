require 'rails_helper'

describe 'User see the stock' do
  it 'on warehouse details' do
    # Arrange
    user = User.create!(name: 'Phoenix Ikki', email: 'ikki@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth: 30,
                                     supplier:, sku: 'PROD-A123')
    product_b = ProductModel.create!(name: 'Produto B', weight: 1, width: 10, height: 20, depth: 30,
                                     supplier:, sku: 'PROD-B123')

    ProductModel.create!(name: 'Produto C', weight: 1, width: 10, height: 20, depth: 30, supplier:, sku: 'PROD-C123')

    3.times { StockProduct.create!(order:, warehouse:, product_model: product_a) }
    2.times { StockProduct.create!(order:, warehouse:, product_model: product_b) }

    # Act
    login_as user
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    within('section#stock_products') do
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x PROD-A123'
      expect(page).to have_content '2 x PROD-B123'
      expect(page).not_to have_content 'PROD-C123'
    end
  end

  it 'and written off an item' do
    # Arrange
    user = User.create!(name: 'Phoenix Ikki', email: 'ikki@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

    product = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth: 30, supplier:,
                                   sku: 'PROD-A123')

    3.times { StockProduct.create!(order:, warehouse:, product_model: product) }

    # Act
    login_as user
    visit root_path
    click_on 'Aeroporto SP'
    select 'PROD-A123', from: 'Item para saída'
    fill_in 'Destinatário',	with: 'Phoenix Ikki'
    fill_in 'Endereço Destino', with: 'Estrada de ouro, 12 - Olímpo - Grécia'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '2 x PROD-A123'
  end
end
