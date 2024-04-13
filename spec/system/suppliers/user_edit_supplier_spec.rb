require 'rails_helper'

describe 'User edit Warehouse' do
  it 'from homepage' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                     full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_field 'Nome fantasia', with: 'ACME'
    expect(page).to have_field 'Razão social', with: 'ACME LTDA'
    expect(page).to have_field 'CNPJ', with: '434472216000123'
    expect(page).to have_field 'Endereço', with: 'Av das Palmas, 100'
    expect(page).to have_field 'Cidade', with: 'Bauru'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'contato@acme.com'
  end

  it 'successfully' do
    # Arrange
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                     registration_number: '60279287182000123', full_address: 'Torre da Indústria Brasil LTDA',
                     city: 'Teresina', state: 'PI', email: 'vendedor@spark.com.br')

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'Spark'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'ACME'
    fill_in 'Razão social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '434472216000123'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Atualizar Fornecedor'

    # Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 434472216000123'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'with incomplete data' do
    # Arrange
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                     registration_number: '60279287182000123', full_address: 'Torre da Indústria Brasil LTDA',
                     city: 'Teresina', state: 'PI', email: 'vendedor@spark.com.br')

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'Spark'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Não foi possível atulizar o fornecedor'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
  end
end
