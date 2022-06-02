require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    user = User.create!(name: 'Edu', email: 'edu@email.com', password: 'password')
    user_2 = User.create!(name: 'Duda', email: 'duda@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    Supplier.create!(corporate_name: 'GYN LTDA', brand_name: 'GOIÁNIA', 
                     registration_number: '00000000000002', full_address: 'Serrinha', city: 'Goiânia', state: 'Goiás', email: 'gyn@gyn.com')

    order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user_2
    patch order_path(order.id), params: { order: { supplier_id: 1}} 
    
    
    expect(response).to redirect_to root_path
  end
end