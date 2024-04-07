require 'rails_helper'

describe 'User view homepage' do
  it 'sees the application name' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end
