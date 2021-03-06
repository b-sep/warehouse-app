require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
  
    visit root_path
    click_on 'Meus pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    user_1 = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    user_2 = User.create!(name: 'Edu', email: 'edu@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order_1 = Order.create!(user: user_1,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    order_2 = Order.create!(user: user_2,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'delivered')
    order_3 = Order.create!(user: user_1,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'canceled')

    login_as user_1
    visit root_path
    click_on 'Meus pedidos'

    expect(page).to have_content "#{order_1.code}"
    expect(page).to have_content 'Pendente'
    expect(page).to have_content "#{order_3.code}"
    expect(page).to have_content 'Cancelado'
    expect(page).not_to have_content "#{order_2.code}"
    expect(page).not_to have_content 'Entregue'
  end

  it 'e visita um pedido' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order_1 = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order_1.code

    expect(page).to have_content 'Detalhes do pedido'
    expect(page).to have_content order_1.code
    expect(page).to have_content 'Galpão destino: BSB - Galpão Brasília'
    expect(page).to have_content 'Fornecedor: BRASILINHA - 00000000000001'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data prevista de entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    user_1 = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    user_2 = User.create!(name: 'Edu', email: 'edu@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order_1 = Order.create!(user: user_2,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    order_2 = Order.create!(user: user_2,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user_1
    visit root_path
    click_on 'Meus pedidos'
    visit order_path(order_1.id)

    expect(current_path).not_to eq order_path(order_1.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem acesso a esse pedido'

  end

  it 'e vê itens de um pedido' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    product_1 = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
                                     height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)
    product_2 = ProductModel.create!(name: 'Produto B', weight: 10, width: 25, 
                                     height: 1, depth: 15, sku: 'TVZC1234569932501812', supplier: supplier)
    product_3 = ProductModel.create!(name: 'Produto C', weight: 25, width: 10, 
                                     height: 1, depth: 20, sku: 'TVZC1234569932501813', supplier: supplier)

    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    
    order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    OrderItem.create!(product_model: product_1, order: order, quantity: 20)
    OrderItem.create!(product_model: product_2, order: order, quantity: 33)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code


    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '20x Produto A'
    expect(page).to have_content '33x Produto B'
  end
end