class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: %i[show edit update delivered canceled]

  def index
    @orders = current_user.orders
  end

  def new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    @order = Order.new
  end

  def create
    @order = Order.new(set_order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert]  = 'Pedido não salvo'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(set_order_params)
      redirect_to @order, notice: 'Pedido editado com sucesso'
    else
      flash.now[:alert] = 'Erro ao editar pedido'
      render :new, status: :unprocessable_entity
    end
  end

  def search
    @query = params[:query]
    @orders = Order.where("code LIKE ?", "%#{params[:query]}%")
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
      end
    end
    redirect_to @order, notice: 'Status do pedido atualizado com sucesso'
  end

  def canceled
    @order.canceled!
    redirect_to @order, notice: 'Status do pedido atualizado com sucesso'
  end

  private

  def set_order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])
    unless @order.user == current_user
      return redirect_to root_path, alert: 'Você não tem acesso a esse pedido'
    end
  end
end