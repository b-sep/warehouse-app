require 'rails_helper'

describe 'Usuário clica em link para adicionar galpão' do
  it 'e vê formulário' do
    #arrange

    #act
    visit root_path
    click_on 'Adicionar galpão'

    #assert
    expect(page).to have_field('Nome:')
    expect(page).to have_field('Código:')
    expect(page).to have_field('Cidade:')
    expect(page).to have_field('Área:')
    expect(page).to have_field('Endereço:')
    expect(page).to have_field('Cep:')
    expect(page).to have_field('Descrição:')

  end

  it 'e adiciona galpão com sucesso' do
    #arrange

    #act
    visit root_path
    click_on 'Adicionar galpão'
    fill_in 'Nome:', with: 'Galpão Brasília'
    fill_in 'Código:', with: 'BSB'
    fill_in 'Cidade:', with: 'Brasília'
    fill_in 'Área:', with: 40000
    fill_in 'Endereço:', with: 'Santa-Maria'
    fill_in 'Cep:', with: '72000-000'
    fill_in 'Descrição:', with: 'Galpão destinado a toda região centro-oeste'
    click_on 'Adicionar galpão'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão Brasília'
    expect(page).to have_content 'BSB'
    expect(page).to have_content 'Brasília'
    expect(page).to have_content '40000 m2'

  end
end