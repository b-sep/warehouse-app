class Api::V1::WarehousesController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_error

  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :update_at])
  rescue
    render status: 404
  end

  def index
    warehouse = Warehouse.all
    render status: 200, json: warehouse.as_json(except: [:created_at, :update_at])
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :zip_code, :description)
    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end

  private
  
  def return_error
    render status: 500
  end
end
