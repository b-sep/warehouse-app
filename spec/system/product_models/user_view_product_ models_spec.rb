require 'rails_helper'

describe 'usuário clica em link para ver modelos de produtos' do
  it 'a partir do menu' do

    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Modelos de Produtos'
  end

  it 'e vê modelos cadastrados' do
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    ProductModel.create!(name: 'NOT S', weight: 1000, width: 30, height: 20, depth: 15, sku: 'NOT2-SAMSU-XXIT90000', supplier: supplier)
    
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to_not have_content 'Nenhum Modelo de Produto cadastrado'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'BRASILINHA'
    expect(page).to have_content 'NOT S'
    expect(page).to have_content 'NOT2-SAMSU-XXIT90'
    expect(page).to have_content 'BRASILINHA'
  end

  it 'e vê mensagem dizendo que não existem modelos' do
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Nenhum Modelo de Produto cadastrado'
  end
end