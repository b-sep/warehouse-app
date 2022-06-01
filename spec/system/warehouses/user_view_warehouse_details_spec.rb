require 'rails_helper'

describe 'Usuário clica em link com nome do galpão' do
  it 'e vê detalhes do galpão' do
    user = User.create!(name: 'beto', email: 'b.treina@dev.com.br', password: '123456')
    Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    #act
    login_as user
    visit root_path
    click_on 'Galpão Brasília'

    #assert
    expect(page).to have_content('Galpão BSB')
    expect(page).to have_content('Nome: Galpão Brasília')
    expect(page).to have_content('Cidade: Brasília')
    expect(page).to have_content('Área: 40000 m2')
    expect(page).to have_content('Endereço: Santa-Maria')
    expect(page).to have_content('Cep: 72000-000')
    expect(page).to have_content('Descrição: Galpão destinado a toda região centro-oeste')
  end

  it 'e clica em link para voltar a listagem de galpões' do
    user = User.create!(name: 'beto', email: 'b.treina@dev.com.br', password: '123456')
    Warehouse.create(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    #act
    login_as user
    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Voltar'

    #assert
    expect(current_path).to eq root_path
  end
end