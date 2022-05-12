require 'rails_helper'

describe 'usuário acessa detalhes de um modelo de produto' do
  it 'e vê detalhes' do
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'TV 32'

    expect(current_path).to eq product_model_path(ProductModel.last[:id])
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'peso: 8000 gramas'
    expect(page).to have_content 'largura: 70 cms'
    expect(page).to have_content 'altura: 45 cms'
    expect(page).to have_content 'profundidade: 10 cms'
    expect(page).to have_content 'Código de Barras: TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Fornecedor: BRASILINHA'
  end

  it 'e volta para listagem de modelos de produtos' do
    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'TV 32'
    click_on 'voltar'

    expect(current_path).to eq product_models_path
  end
end