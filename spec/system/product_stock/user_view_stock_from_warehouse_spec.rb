require 'rails_helper'

describe 'usuário vê estoque' do
  it 'na tela do galpão' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    order = Order.create(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.weeks.from_now)

    product_1 = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                     height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)
    product_2 = ProductModel.create!(name: 'Galaxy S20e', weight: 1, width: 15, 
                                     height: 35, depth: 15, sku: 'GL201234569932501811', supplier: supplier)
    product_3 = ProductModel.create!(name: 'Galaxy S20', weight: 1, width: 20, 
                                     height: 30, depth: 20, sku: 'GS201234569932501811', supplier: supplier)

    10.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_1) }
    5.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_2) }
    
    login_as user
    visit root_path
    click_on 'Galpão Brasília'

    within('section#stock_product') do
      expect(page).to have_content 'Itens em estoque'
      expect(page).to have_content '10x Galaxy S10e - GLXC1234569932501811'
      expect(page).to have_content '5x Galaxy S20e - GL201234569932501811'
      expect(page).not_to have_content 'GS201234569932501811'
    end
  end

  it 'e não tem nenhum item no galpão' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    login_as user
    visit root_path
    click_on 'Galpão Brasília'

    expect(page).to have_content 'Nenhum item em estoque'
  end

  it 'e dá baixa em um item' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA',registration_number: '00000000000001', 
                                full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    order = Order.create(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.weeks.from_now)

    galaxy_s10e = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                      height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)
    2.times { StockProduct.create!(warehouse: warehouse, product_model: galaxy_s10e, order: order) }

    login_as user
    visit root_path
    click_on 'Galpão Brasília'
    select 'GLXC1234569932501811', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Treina Dev'
    fill_in 'Endereço Destino', with: 'Brasília - DF'
    click_on 'Confirmar retirada'
    
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1x Galaxy S10e - GLXC1234569932501811'
  end
end