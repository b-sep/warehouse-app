class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show]

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
      flash.now[:notice] = 'Erro ao adicionar Modelo de Produto'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end

  def set_product_model
    @pm = ProductModel.find(params[:id])
  end
end