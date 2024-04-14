class AddWidthToProductModels < ActiveRecord::Migration[7.1]
  def change
    add_column :product_models, :width, :integer
  end
end
