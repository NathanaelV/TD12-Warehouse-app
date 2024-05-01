class Api::V1::WarehousesController < ActionController::API
  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: %i[created_at updated_at])
  rescue StandardError
    render status: 404
  end
end
