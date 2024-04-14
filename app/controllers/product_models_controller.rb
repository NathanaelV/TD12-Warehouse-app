class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.order(:brand_name)
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
    else
      @suppliers = Supplier.order(:brand_name)
      flash.now[:alert] = 'Não foi possível cadastrar o modelo de produto'
      render :new
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :height, :width, :depth, :weight, :sku, :supplier_id)
  end
end
