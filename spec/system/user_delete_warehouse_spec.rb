require 'rails_helper'

describe "User remove a warehouse" do
  it 'successfully' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000',
                      cep: '20000-000', description: 'Galpão do Rio')

    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Deletar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
  end

  it 'and does not delete the others' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000',
                      cep: '20000-000', description: 'Galpão do Rio')

    Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, address: 'Av Centro',
                      cep: '46000-000', description: 'Galpão para cargas mineiras')

    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Deletar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).to have_content 'BHZ'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
  end
end
