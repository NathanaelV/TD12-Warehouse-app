require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                  registration_number: '123123123000322', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      product_models = ProductModel.new(name: '', weight: 8000, width: 80, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90',
                                        supplier:)

      # Act
      # Assert
      expect(product_models).not_to be_valid
    end

    it 'sku is mandatory' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                  registration_number: '123123123000322', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      product_models = ProductModel.new(name: 'TV-32', weight: 8000, width: 80, height: 45, depth: 10, sku: '',
                                        supplier:)

      # Act
      # Assert
      expect(product_models).not_to be_valid
    end
  end
end
