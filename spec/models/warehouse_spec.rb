require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  # it { is_expected.to validate_presence_of(:city) }
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when cep is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 1000,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: nil,
                                  description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when descripiton is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio',
                                  area: 1000, description: '')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end

    it 'false when code is already in use' do
      # Arrange
      Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio',
                       area: 1000, description: 'Alguma descrição')

      invalid_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', cep: '25999-999', city: 'Rio',
                                        area: 5000, description: 'Outra descrição')

      # Assert
      expect(invalid_warehouse).not_to be_valid
    end
  end
end