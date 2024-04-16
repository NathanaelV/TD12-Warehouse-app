require 'rails_helper'

describe 'User sign up' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail',	with: 'maria@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(User.last.name).to eq 'Maria'
    expect(page).to have_content 'Olá Maria'
    expect(page).to have_content 'maria@email.com'
    expect(page).to have_button 'Sair'
  end
end
