require 'rails_helper'

describe 'User edit Warehouse' do
  it 'from homepage' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000',
                      cep: '20000-000', description: 'Galpão do Rio')

    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    # Assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Rio'
    expect(page).to have_field 'Descrição', with: 'Galpão do Rio'
    expect(page).to have_field 'Código', with: 'SDU'
    expect(page).to have_field 'Endereço', with: 'Av do Porto, 1000'
    expect(page).to have_field 'Cidade', with: 'Rio de Janeiro'
    expect(page).to have_field 'CEP', with: '20000-000'
    expect(page).to have_field 'Área', with: '60000'
  end

  it 'successfully' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000',
                      cep: '20000-000', description: 'Galpão do Rio')

    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome',	with: 'Galpão Internacional'
    fill_in 'Código',	with: 'GIG'
    fill_in 'Cidade',	with: 'Ilha do Governador'
    fill_in 'Área', with: '80000'
    fill_in 'Endereço', with: 'Av do Galeão, 1000'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Descrição', with: 'Galpão da Ilha'
    click_on 'Atualizar Galpão'

    # Assert
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Galpão Internacional'
    expect(page).to have_content 'Nome: Galpão Internacional'
    expect(page).to have_content 'Galpão da Ilha'
    expect(page).to have_content 'GIG'
    expect(page).to have_content 'Endereço: Av do Galeão'
    expect(page).to have_content 'Cidade: Ilha do Governador'
    expect(page).to have_content 'CEP: 20100-000'
    expect(page).to have_content 'Área: 80000'
  end

  it 'and keeps the required fields' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000',
                      cep: '20000-000', description: 'Galpão do Rio')

    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome',	with: 'Galpão Internacional'
    fill_in 'Código',	with: ''
    fill_in 'Cidade',	with: ''
    fill_in 'Área', with: '80000'
    fill_in 'Endereço', with: 'Av do Galeão, 1000'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Descrição', with: 'Galpão da Ilha'
    click_on 'Atualizar Galpão'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end
