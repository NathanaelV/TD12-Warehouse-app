class RenameSeralNumberToSerialNumberInStockProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :stock_products, :seral_number, :serial_number
  end
end
