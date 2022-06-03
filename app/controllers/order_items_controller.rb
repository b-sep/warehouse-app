class OrderItemsController < ApplicationController
  before_action :get_order, only: %i[ new create ]
  def new
    @products = @order.supplier.product_models
    @order_item = OrderItem.new
  end

  def create
    @order_item = @order.order_items.new(order_item_params)
    if @order_item.save
      redirect_to @order, notice: 'Item adicionado com sucesso'
    else
      @products = @order.supplier.product_models
      flash.now[:alert] = 'Erro ao adicionar item'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end

  def get_order
    @order = Order.find(params[:order_id])
  end
end