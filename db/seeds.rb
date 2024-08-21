# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User
user = User.create!(name: 'Phoenix Ikki', email: 'ikki@saintseiya.com', password: 'password')
User.create!(name: 'Dragon Shiryu', email: 'shiryu@saintseiya.com', password: 'password')

# Supplier
supplier = Supplier.find_or_create_by!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                       registration_number: '434472216000123', full_address: 'Av das Palmas, 100',
                                       city: 'Bauru', state: 'SP', email: 'contato@acme.com')

Supplier.create(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                registration_number: '434472216000123', full_address: 'Torre da Spark Brasil',
                city: 'Teresina', state: 'PI', email: 'vendedor@spark.com.br')

# Warehouse
warehouse = Warehouse.find_or_create_by!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                         address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                         description: 'Galpão destinado para cargas internacionais')

Warehouse.find_or_create_by!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                             address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

Warehouse.find_or_create_by!(name: 'Viracopos', code: 'VCP', city: 'Campinas', area: 80_000,
                             address: ' Rod. Santos Dumont, km 60', cep: '13055-900',
                             description: 'Galpão do aeroporto internacional de Campinas')

# Product Model
product_model = ProductModel.find_or_create_by!(supplier:, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70,
                                                depth: 75, sku: 'CAR-GAMER-1234')
ProductModel.find_or_create_by!(name: 'TV-32', weight: 8000, width: 80, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90',
                                supplier:)
ProductModel.find_or_create_by!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 20, height: 80, depth: 15,
                                sku: 'SOU71-SAMSU-NOIZ77', supplier:)

# Order
order = Order.find_or_create_by!(user:, warehouse:, supplier:, estimated_delivery_date: 2.day.from_now)

# Order Item
OrderItem.find_or_create_by!(product_model:, order:, quantity: 6)

puts 'All datas has been created'
