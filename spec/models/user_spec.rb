require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'show user name and email' do
      # Arrange
      user = User.new(name: 'Julia Almeida', email: 'julia.almeida@email.com')

      # Act
      result = user.description

      # Assert
      expect(result).to eq 'Julia Almeida <julia.almeida@email.com>'
    end
  end
end
