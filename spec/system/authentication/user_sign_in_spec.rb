require 'rails_helper'

describe 'User autenticates' do
  it 'successfully' do
    # Arrange
    User.create!(name: 'João Silva', email: 'joaozinho@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'joaozinho@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_button 'Sair'
    expect(page).not_to have_link 'Entrar'
    within('nav') do
      expect(page).to have_content 'João Silva <joaozinho@email.com>'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'and logout' do
    # Arrange
    User.create!(email: 'joaozinho@email.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'joaozinho@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joaozinho@email.com'
  end
end
