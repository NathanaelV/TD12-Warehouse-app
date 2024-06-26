require 'rails_helper'

describe 'User view product model' do
  it 'if authenticated' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'from homepage' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'successfully' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                registration_number: '123123123000322', full_address: 'Av Nações Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV-32', weight: 8000, width: 80, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90',
                         supplier:)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 20, height: 80, depth: 15,
                         sku: 'SOU71-SAMSU-NOIZ77', supplier:)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content 'TV-32'
    expect(page).to have_content 'SKU TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Fornecedor Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SKU SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Fornecedor Samsung'
  end

  it 'and there are no product model' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'

    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
end
