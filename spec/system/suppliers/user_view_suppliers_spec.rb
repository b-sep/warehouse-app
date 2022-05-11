require 'rails_helper'

describe 'usuário clica em link para ver fornecedores' do
  it 'a partir do do menu' do
    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedores'
  end

  it 'e vê fornecedores cadastrados' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    Supplier.create!(corporate_name: 'RF2 LTDA', brand_name: 'RIACHO', registration_number: '00000000000002', full_address: 'qs 18 cond 31', city: 'Riacho Fundo', state: 'Distrito Federal', email: 'rf2@rf2.com')

    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
    expect(page).not_to have_content 'Não existem fornecedores cadastrados'
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'BRASILINHA'
    expect(page).to have_content 'Taguatinga - Distrito Federal'
    expect(page).to have_content 'RIACHO'
    expect(page).to have_content 'Riacho Fundo - Distrito Federal'
  end

  it 'e vê mensagem dizendo que não existem fornecedores' do
    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end

  it 'e volta para a página inicial' do
    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end
    click_on 'Galpões & Estoque'

    expect(current_path).to eq root_path
  end
end