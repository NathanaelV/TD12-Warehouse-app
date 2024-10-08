require 'rails_helper'

describe 'User register an order' do
  it 'if authenticated ' do
    # Arrange

    # Act
    visit root_path
    click_on 'Registrar Pedido'

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'successfully' do
    # Arrange
    user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                     registration_number: '60279287182000123', full_address: 'Torre da Indústria Brasil LTDA',
                     city: 'Teresina', state: 'PI', email: 'vendedor@spark.com.br')

    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    future_date = 2.day.from_now.strftime('%d/%m/%Y')

    mail = double('mail', deliver: true)
    mailer_double = double('OrdersMailer', notify_new_order: mail)
    allow(OrdersMailer).to receive(:with).and_return(mailer_double)
    # allow(mailer_double).to receive(:notify_new_order).and_return(mail)

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Galpão Rio', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: future_date
    click_on 'Criar Pedido'

    # Assert
    expect(mailer_double).to have_received(:notify_new_order)
    expect(mail).to have_received(:deliver)
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABCD1234'
    expect(page).to have_content 'Galpão Destino: SDU - Galpão Rio'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergião <sergiao@email.com>'
    expect(page).to have_content "Data Prevista de Entrega: #{future_date}"
    expect(page).to have_content 'Status: Pendente'
    expect(page).not_to have_content 'Aeroporto SP'
    expect(page).not_to have_content 'Spark Industries Brasil LTDA'
  end

  it 'and does not give the name' do
    # Arrange
    user = User.create!(name: 'Sergião', email: 'sergiao@email.com', password: '1234abcd')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                      address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Galpão Rio', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Criar Pedido'

    # Assert
    expect(page).to have_content 'Não foi possível registrar o pedido.'
    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
  end
end
