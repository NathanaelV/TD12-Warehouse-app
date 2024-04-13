require 'rails_helper'

describe "User register supplier" do
  it 'from homepage' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    # Assert
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'E-mail'
  end

  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome fantasia', with: 'ACME'
    fill_in 'Razão social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '4717614000189'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 4717614000189'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'with incomplete data' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedor'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome fantasia', with: ''
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor não foi criado'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end
