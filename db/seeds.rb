# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user = User.create!(name: 'Phoenix Ikki', email: 'ikki@saintseiya.com', password: 'password')
User.create!(name: 'Dragon Shiryu', email: 'shiryu@saintseiya.com', password: 'password')

supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472216000123',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

product_model = ProductModel.create!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                  depth: 75, sku: 'CAR-GAMER-1234')
ProductModel.create!(name: 'TV-32', weight: 8000, width: 80, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90',
                                  supplier:)
ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 20, height: 80, depth: 15,
                                  sku: 'SOU71-SAMSU-NOIZ77', supplier:)

order = Order.create!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)
