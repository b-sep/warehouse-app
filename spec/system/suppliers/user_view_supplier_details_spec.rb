require 'rails_helper'

describe 'usuário acessa detalhes de um fornecedor' do
  it 'e vê informações' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end
    click_on 'BRASILINHA'

    expect(current_path).to eq supplier_path(Supplier.last[:id])
    expect(page).to have_content  'BSB LTDA'
    expect(page).to have_content  'BRASILINHA'
    expect(page).to have_content 'CNPJ: 0000000000001'
    expect(page).to have_content 'qnd 03 lote 22'
    expect(page).to have_content 'Taguatinga'
    expect(page).to have_content 'Distrito Federal'
    expect(page).to have_content 'bsb@bsb.com'
  end

  it 'e volta para página inicial' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    visit root_path
    within ('nav') do 
      click_on 'Fornecedores'
    end
    click_on 'BRASILINHA'
    click_on 'Galpões & Estoque'

    expect(current_path).to eq root_path
  end
end