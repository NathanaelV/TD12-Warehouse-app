require 'rails_helper'

describe 'User view suppliers details' do
  it 'from homepage' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'ACME'

    # Assert
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 434472216000123'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'back to homepage' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'ACME'
    click_on 'Menu'

    # Assert
    expect(current_path).to eq root_path
  end
end
