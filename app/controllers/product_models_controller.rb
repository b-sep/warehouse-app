class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_product_model, only: %i[show edit update]
  before_action :set_suppliers, only: %i[new edit]

  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @pm = ProductModel.new
  end

  def create
    @pm = ProductModel.new(product_model_params)

    if @pm.save
      redirect_to @pm, notice: 'Modelo de Produto adicionado com sucesso'
    else
      @suppliers = Supplier.order(:brand_name)
      flash.now[:notice] = 'Erro ao adicionar Modelo de Produto'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @pm.update(product_model_params)
      redirect_to @pm, notice: 'Modelo de Produto atualizado com sucesso'
    else
      @suppliers = Supplier.order(:brand_name)
      flash.now[:notice] = 'Erro ao atualizar Modelo de Produto'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end

  def set_product_model
    @pm = ProductModel.find(params[:id])
  end

  def set_suppliers
    @suppliers = Supplier.order(:brand_name)
  end
  
end