class WarehousesController < ApplicationController
  def show
    set_warehouse
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

  def edit
    set_warehouse
  end

  def update
    set_warehouse

    if @warehouse.update(warehouse_params)
      redirect_to @warehouse, notice: 'Galpão salvo com sucesso'
    else
      flash.now[:notice] = 'Erro ao salvar galpão'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip_code, :description)
  end

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

end