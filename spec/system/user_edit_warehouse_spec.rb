require 'rails_helper'

describe 'Usuário clica em link para editar galpão' do

  it 'na página de detalhes e ve formulário com campos preenchidos' do
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Editar galpão'

    expect(page).to have_field('Nome', with: 'Galpão Brasília')
    expect(page).to have_field('Código', with: 'BSB')
    expect(page).to have_field('Cidade', with: 'Brasília')
    expect(page).to have_field('Área', with: '40000')
    expect(page).to have_field('Endereço', with: 'Santa-Maria')
    expect(page).to have_field('Cep', with: '72000-000')
    expect(page).to have_field('Descrição', with: 'Galpão destinado a toda região centro-oeste')
  end

  it 'vê formulário preenchido e edita com sucesso o galpão' do
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Editar galpão'
    fill_in 'Nome', with: 'Galpão Salvador'
    fill_in 'Código', with: 'SSA'
    fill_in 'Cidade', with: 'Salvador'
    fill_in 'Área', with: '10000'
    fill_in 'Endereço', with: 'Pelorinho, 1000'
    fill_in 'Cep', with: '10000-222'
    fill_in 'Descrição', with: 'Perto do farol'
    click_on 'Salvar galpão'

    expect(page).to have_content 'Galpão salvo com sucesso'
    expect(page).to have_content 'Nome: Galpão Salvador'
    expect(page).to have_content 'Galpão SSA'
    expect(page).to have_content 'Cidade: Salvador'
    expect(page).to have_content 'Área: 10000 m2'
    expect(page).to have_content 'Endereço: Pelorinho, 1000'
    expect(page).to have_content 'Cep: 10000-222'
    expect(page).to have_content 'Descrição: Perto do farol'
  end

  it 'vê formulário e edita sem sucesso o galpão' do
    warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

    visit root_path
    click_on 'Galpão Brasília'
    click_on 'Editar galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    click_on 'Salvar galpão'

    expect(page).to have_content 'Erro ao salvar galpão'
  end
end