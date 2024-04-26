require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Generate a serial number' do
    it 'when creating a Stock Product' do
      # Arrange
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :delivered)

      product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                           depth: 75, sku: 'CAR-GAMER-1234')

      # Act
      stock_product = StockProduct.create!(order:, warehouse:, product_model:)

      # Assert
      expect(stock_product.serial_number.length).to eq 20
    end

    it 'and cannot be modified' do
      # Arrange
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')

      other_warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                         address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now, status: :delivered)

      product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                           depth: 75, sku: 'CAR-GAMER-1234')

      stock_product = StockProduct.create!(order:, warehouse:, product_model:)
      original_serial_number = stock_product.serial_number

      # Act
      stock_product.update!(warehouse: other_warehouse)

      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
