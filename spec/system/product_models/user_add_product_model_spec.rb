require 'rails_helper'

describe 'usuário clica em link para adicionar modelo de produto' do
  it 'e adiciona modelo de produto com sucesso' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000100000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Adicionar Modelo de Produto'
    fill_in 'Nome', with: 'TV 50'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '50'
    fill_in 'Altura', with: '70'
    fill_in 'Profundidade', with: '15'
    fill_in 'Código de Barras', with: '00000000000000000000'
    page.select 'BRASILINHA', from: 'Fornecedor'
    click_on 'Adicionar Modelo de Produto'

    expect(current_path).to eq product_model_path(ProductModel.last[:id])
    expect(page).to_not have_content 'Erro ao adicionar Modelo de Produto'
    expect(page).to have_content 'Modelo de Produto adicionado com sucesso'
  end

  it 'e tenta adicionar sem preencher formulário' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000100000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
    
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Adicionar Modelo de Produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    click_on 'Adicionar Modelo de Produto'

    expect(page).to have_content 'Erro ao adicionar Modelo de Produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
  end
end