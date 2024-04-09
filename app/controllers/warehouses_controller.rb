class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new; end

  def create
    # Aqui dentro que vamos:
    # 1 - Receber os dados enviados
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)

    # 2 - Criar um novo galpão no banco de dados
    Warehouse.create(warehouse_params)

    # 3 - Redirecionar para a tela inicial
    redirect_to root_path
  end
end
