class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    @order = Order.new
  end

  def create
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    @order = Order.new(set_order_params)
    @order.user = current_user
    
    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else
      flash.now[:alert]  = 'Pedido não salvo'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end