require 'rails_helper'

describe 'Usuário clica em link para adicionar galpão' do
  it 'e vê formulário' do
    #arrange

    #act
    visit root_path
    click_on 'Adicionar galpão'

    #assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cep')
    expect(page).to have_field('Descrição')

  end

  it 'e adiciona galpão com sucesso' do
    #arrange

    #act
    visit root_path
    click_on 'Adicionar galpão'
    fill_in 'Nome', with: 'Galpão Brasília'
    fill_in 'Código', with: 'BSB'
    fill_in 'Cidade', with: 'Brasília'
    fill_in 'Área', with: 40000
    fill_in 'Endereço', with: 'Santa-Maria'
    fill_in 'Cep', with: '72000-000'
    fill_in 'Descrição', with: 'Galpão destinado a toda região centro-oeste'
    click_on 'Adicionar galpão'

    #assert
    expect(current_path).to eq warehouse_path(Warehouse.last[:id])
    expect(page).to have_content('Galpão adicionado com sucesso')
    expect(page).to have_content('Galpão BSB')
    expect(page).to have_content('Nome: Galpão Brasília')
    expect(page).to have_content('Cidade: Brasília')
    expect(page).to have_content('Área: 40000 m2')
    expect(page).to have_content('Endereço: Santa-Maria')
    expect(page).to have_content('Cep: 72000-000')
    expect(page).to have_content('Descrição: Galpão destinado a toda região centro-oeste')

  end

  it 'e tenta adicionar galpão sem preencher o formulário todo' do
    #arrange

    #act
    visit root_path
    click_on 'Adicionar galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cep', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Adicionar galpão'

    #assert

    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cep não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
    expect(page).to have_content 'Cep não é válido'
    
  end
end