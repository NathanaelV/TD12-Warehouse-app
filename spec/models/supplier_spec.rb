require 'rails_helper'

RSpec.describe Supplier, type: :model do
  # it { is_expected.to validate_presence_of(:city) }
  describe '#valide?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when brand_name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when registration_number is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when full_address is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: '', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when city is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: '', state: 'SP', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when state is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: '', email: 'contato@acme.com')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
  
      it 'false when email is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: '')
  
        # Act & Assert
        expect(supplier.valid?).to eq false
      end
    end

    it 'false when registration_number is already in use' do
      # Arrange
      Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                       full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      invalide_supplier = Supplier.create(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                                       registration_number: '434472216000123', full_address: 'Torre da Spark Brasil',
                                       city: 'Teresina', state: 'PI', email: 'vendedor@spark.com.br')

      # Act & Assert
      expect(invalide_supplier).not_to be_valid
    end
  end
end
