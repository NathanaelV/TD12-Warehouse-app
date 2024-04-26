require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'code must be mandatory' do
      # Arrange
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

      # Act
      result = order.valid?

      # Assert
      expect(result).to be true
    end

    it 'presence true for estimated_delivery_date' do
      # Arrange
      order = Order.new

      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      # Assert
      expect(result).to be true
    end

    it 'estimated delivery date must not be passed' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)

      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'estimated delivery date must not be today' do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'estimated delivery date must be after today' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end

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

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)

      # Act
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'code must be unique' do
      # Arrange
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      first_order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 1.week.from_now)
      second_order = Order.new(user:, warehouse:, supplier:, estimated_delivery_date: 5.day.from_now)

      # Act
      second_order.save!

      # Assert
      expect(second_order.code).not_to eq first_order.code
    end

    it 'and cannot be modified' do
      # Arrange
      user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                  registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                  city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 1.day.from_now)
      original_code = order.code

      # Act
      order.update!(estimated_delivery_date: 1.month.from_now)

      # Assert
      expect(order.code).to eq(original_code)
    end
  end
end
