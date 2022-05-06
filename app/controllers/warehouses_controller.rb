class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end
  
  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to @warehouse, notice: 'Galpão adicionado com sucesso'
    else
      flash.now[:notice] = "Galpão não cadastrado"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip_code, :description)
  end

end