require 'rails_helper'

describe 'usuário cadastra um pedido' do

  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                  address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
    Warehouse.create!(name: 'Galpão Brasíliaa', code: 'BSC', city: 'Brasília2', area: 50_000, 
                      address: 'Santa-Maria2', zip_code: '71000-000', description: 'Galpão destinado a toda região centro-ooeste')
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
                                registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    Supplier.create!(corporate_name: 'BSSB LTDA', brand_name: 'BRASILINHAA', 
                     registration_number: '00000000000002', full_address: 'qnd 04 lote 22', city: 'Taguatinga sul', state: 'Distrito Federaal', email: 'bsb@bsb2.com')

    login_as user
    visit root_path
    click_on 'Registrar pedido'
    select warehouse.name, from: 'Galpão destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '20/08/2022'
    click_on 'Registrar'
    
    expect(page).to have_content Order.last.code
    expect(page).to have_content 'Pedido cadastrado com sucesso'
    expect(page).to have_content 'Galpão destino: Galpão Brasília'
    expect(page).to have_content 'Fornecedor: BSB LTDA'
    expect(page).to have_content 'Usuário responsável: Júnior | jr@email.com'
    expect(page).to have_content 'Data prevista de entrega: 20/08/2022'
    expect(page).not_to have_content 'Galpão Brasíliaa'
    expect(page).not_to have_content 'BSSB LTDA'
  end
end