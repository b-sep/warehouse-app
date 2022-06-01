require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    user = User.create!(name: 'Júnior', email: 'jr@jr.com', password: 'password')

    login_as user
    visit root_path

    within 'header nav' do
      expect(page).to have_field 'Buscar pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve estar autenticado' do

    visit root_path

    within 'header nav' do
      expect(page).not_to have_field 'Buscar pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'e encontra um pedido' do
    user = User.create!(name: 'Junior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    fill_in 'Buscar pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultado da busca por: #{order.code}"
    expect(page).to have_content '1 Pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão destino: BSB - Galpão Brasília'
    expect(page).to have_content 'Fornecedor: BRASILINHA - 00000000000001'
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(name: 'Junior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    warehouse_2 = Warehouse.create!(name: 'Galpão Goiás', code: 'GYN', city: 'Goiânia', area: 60_000, 
                                    address: 'Serrinha', zip_code: '73000-000', description: 'Galpão destinado a toda região goiana')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('BSB1234567')                          
    order_1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('BSB7654321')
    order_2 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GYN1234567') 
    order_3 = Order.create!(user: user, warehouse: warehouse_2 , supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    fill_in 'Buscar pedido', with: 'BSB'
    click_on 'Buscar'

    expect(page).to have_content '2 Pedidos encontrados'
    expect(page).to have_content 'BSB1234567'
    expect(page).to have_content 'BSB7654321'
    expect(page).to have_content 'Galpão destino: BSB - Galpão Brasília'
    expect(page).not_to have_content 'GYN1234567'
    expect(page).not_to have_content 'Galpão destino: GYN - Galpão Goiás' 
  end

  it 'e termo procurado não encontra nada' do
    user = User.create!(name: 'Junior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    fill_in 'Buscar pedido', with: '#@!!'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: #@!!'
    expect(page).to have_content '0 Pedidos encontrados'
  end
end