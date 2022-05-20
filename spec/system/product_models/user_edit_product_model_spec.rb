require 'rails_helper'

describe 'usuário clica em link para editar modelo de produto' do
  it 'e vê formulário preenchido' do
    user = User.create!(name: 'Junior', email: 'jr@jr.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

    login_as user
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'TV 32'
    click_on 'Editar Modelo de Produto'

    expect(page).to have_content 'Editar Modelo de Produto'
    expect(page).to have_field('Nome', with: 'TV 32')
    expect(page).to have_field('Peso', with: '8000')
    expect(page).to have_field('Largura', with: '70')
    expect(page).to have_field('Altura', with: '45')
    expect(page).to have_field('Profundidade', with: '10')
    expect(page).to have_field('SKU', with: 'TV32-SAMSU-XPTO90000')
    expect(page).to have_field('Fornecedor', with: 1)
  end

  it 'vê formulário preenchido e edita com sucesso' do
    user = User.create!(name: 'Junior', email: 'jr@jr.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    supplier2 = Supplier.create!(corporate_name: 'BSA LTDA', brand_name: 'BRASILINHA2', registration_number: '00000000000002', full_address: 'qnd 05 lote 22', city: 'Taguatinga2', state: 'DF', email: 'bsb2@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

    login_as user
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'TV 32'
    click_on 'Editar Modelo de Produto'

    fill_in 'Nome', with: 'TV 33'
    fill_in 'Peso', with: '9000'
    fill_in 'Largura', with: '80'
    fill_in 'Altura', with: '50'
    fill_in 'Profundidade', with: '15'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90001'
    page.select 'BRASILINHA2', from: 'Fornecedor'
    click_on 'Salvar Modelo de Produto'

    expect(page).to have_content 'Modelo de Produto atualizado com sucesso'
    expect(page).to have_content 'TV 33'
    expect(page).to have_content 'peso: 9000 gramas'
    expect(page).to have_content 'largura: 80 cms'
    expect(page).to have_content 'altura: 50 cms'
    expect(page).to have_content 'profundidade: 15 cms'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90001'
    expect(page).to have_content 'Fornecedor: BRASILINHA2'
  end

  it 'vê formulário preenchido e edita sem sucesso' do
    user = User.create!(name: 'Junior', email: 'jr@jr.com', password: '123456')

    supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

    login_as user
    visit root_path
    within ('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'TV 32'
    click_on 'Editar Modelo de Produto'

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    click_on 'Salvar Modelo de Produto'
    
    expect(page).to have_content 'Erro ao atualizar Modelo de Produto'
  end
end
