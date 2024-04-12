require 'rails_helper'

describe 'User register warehouse' do
  it 'from the home screen' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'

    # Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end

  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome',	with: 'Rio de Janeiro'
    fill_in 'Descrição',	with: 'Galpão da zona portuária do Rio'
    fill_in 'Código',	with: 'RIO'
    fill_in 'Endereço',	with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'Cidade',	with: 'Rio de Janeiro'
    fill_in 'CEP',	with: '20100-000'
    fill_in 'Área',	with: '32000'
    click_on 'Criar Galpão'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso.'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32000 m2'
  end

  it 'with incomplete data' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Criar Galpão'

    # Assert
    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(current_path).to eq warehouses_path
  end
end
