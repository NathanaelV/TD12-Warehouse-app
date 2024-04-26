class Warehouse < ApplicationRecord
  has_many :stock_products
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true

  def full_description
    "#{code} - #{name}"
  end
end
