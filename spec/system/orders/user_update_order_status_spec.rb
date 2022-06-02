require 'rails_helper'

describe 'Usuário informa novo status do pedido' do
  it 'e pedido foi entregue' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    order = Order.create(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Pedido entregue'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do pedido: Entregue'
    expect(page).not_to have_button 'Pedido cancelado'
    expect(page).not_to have_button 'Pedido entregue'

  end

  it 'e pedido foi cancelado' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    order = Order.create(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Pedido cancelado'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do pedido: Cancelado'
    expect(page).not_to have_button 'Pedido cancelado'
    expect(page).not_to have_button 'Pedido entregue'
  end
end