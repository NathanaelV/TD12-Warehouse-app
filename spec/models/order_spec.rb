require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Generate a random code' do
    it 'when creating a new code' do
      # Arrange
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: '2022-10-15')

      # Act
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end
  end
end
