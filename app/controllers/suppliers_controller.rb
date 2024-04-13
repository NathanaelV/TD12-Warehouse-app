class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:brand_name, :corporate_name, :registration_number, :full_address, :city, :state, :email)
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:alert] = 'Fornecedor não foi criado'
      render :new
    end
  end
end
