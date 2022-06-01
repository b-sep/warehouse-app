require 'rails_helper'

describe 'usuário clica em deletar galpão' do

  it 'e deleta um galpão com sucesso' do
    user = User.create!(name: 'beto', email: 'b.treina@dev.com.br', password: '123456')
    login_as user
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    login_as user
    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Deletar galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão deletado com sucesso'
    expect(page).to_not have_content 'BSB'
    expect(page).to_not have_content 'Galpão Brasília'
  end

  it 'e não deleta todos os galpões' do
    user = User.create!(name: 'beto', email: 'b.treina@dev.com.br', password: '123456')
    login_as user
    warehouse_1 = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    warehouse_2 = Warehouse.create!(name: 'Galpão teste', code: 'BBB', city: 'Brasília2', area: 50_000, address: 'Santa-Maria2', zip_code: '73000-000', description: 'Galpão destinado a toda região centro-oeste e demais')

    login_as user
    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Deletar galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão deletado com sucesso'
    expect(page).to_not have_content 'BSB'
    expect(page).to_not have_content 'Galpão Brasília'
    expect(page).to have_content 'Galpão teste'
    expect(page).to have_content 'BBB'
  end
end