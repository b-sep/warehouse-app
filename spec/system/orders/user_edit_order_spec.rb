require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(name: 'Edu', email: 'edu@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Edu', email: 'edu@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    Supplier.create!(corporate_name: 'GYN LTDA', brand_name: 'GOIÁNIA', 
                     registration_number: '00000000000002', full_address: 'Serrinha', city: 'Goiânia', state: 'Goiás', email: 'gyn@gyn.com')

    order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Editar pedido'
    fill_in 'Data prevista de entrega', with: 3.weeks.from_now
    select 'GOIÁNIA - 00000000000002', from: 'Fornecedor'
    click_on 'Salvar'

    expect(page).to have_content 'Pedido editado com sucesso'
    expect(page).to have_content 'Fornecedor: GOIÁNIA - 00000000000002'
    expect(page).to have_content "Data prevista de entrega: #{I18n.l(3.weeks.from_now.to_date)}"
  end

  it 'caso seja dono do pedido' do
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
    visit edit_order_path(order)

    expect(current_path).not_to eq edit_order_path(order)
    expect(current_path).to eq root_path
  end
end