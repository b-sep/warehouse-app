require 'rails_helper'

describe 'Usuário adiciona item ao pedido' do
  it 'com sucesso' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 123456)
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    order = Order.create(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
                         height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)
    ProductModel.create!(name: 'Produto B', weight: 10, width: 25, 
                         height: 1, depth: 15, sku: 'TVZC1234569932501812', supplier: supplier)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 20
    click_on 'Salvar'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '20x Produto A'
  end

  it 'e não vê itens produtos de outro fornecedor' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 123456)
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    supplier_2 = Supplier.create!(corporate_name: 'RJ LTDA', brand_name: 'COPACABANA',registration_number: '00000000000002', 
                     full_address: 'Ipanema, 1000', city: 'Leme', state: 'RJ', email: 'rj@rj.com')
    order = Order.create(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
                         height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)
    ProductModel.create!(name: 'Produto B', weight: 10, width: 25, 
                         height: 1, depth: 15, sku: 'TVZC1234569932501812', supplier: supplier_2)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end

  it 'sem sucesso' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 123456)
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    order = Order.create(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
                         height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)
    ProductModel.create!(name: 'Produto B', weight: 10, width: 25, 
                         height: 1, depth: 15, sku: 'TVZC1234569932501812', supplier: supplier)

    login_as user
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Quantidade não pode ficar em branco'
    expect(page).to have_content 'Erro ao adicionar item'
  end
end