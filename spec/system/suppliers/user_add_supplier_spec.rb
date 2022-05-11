require 'rails_helper'

describe 'usuário clica em link para adicionar fornecedor' do
  it 'e vê formulário' do

    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Adicionar Fornecedor'

    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
  end

  it 'e adiciona fornecedor com sucesso' do

    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Adicionar Fornecedor'

    fill_in 'Razão Social', with: 'BSB LTDA'
    fill_in 'Nome Fantasia', with: 'BRASILINHA'
    fill_in 'CNPJ', with: '0000000000001'
    fill_in 'Endereço', with: 'qnd 03 lote 22'
    fill_in 'Cidade', with: 'Taguatinga'
    fill_in 'Estado', with: 'Distrito Federal'
    fill_in 'E-mail', with: 'bsb@bsb.com'
    click_on 'Adicionar fornecedor'

    expect(current_path).to eq supplier_path(Supplier.last[:id])
    expect(page).to have_content('Fornecedor adicionado com sucesso')
    expect(page).to have_content  'BSB LTDA'
    expect(page).to have_content  'BRASILINHA'
    expect(page).to have_content 'CNPJ: 0000000000001'
    expect(page).to have_content 'qnd 03 lote 22'
    expect(page).to have_content 'Taguatinga'
    expect(page).to have_content 'Distrito Federal'
    expect(page).to have_content 'bsb@bsb.com'
  end

  it 'e tenta adicionar fornecedor sem preencher formulário' do
    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Adicionar Fornecedor'

    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Adicionar fornecedor'

    expect(page).to have_content 'Erro ao adicionar fornecedor'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
  end
end