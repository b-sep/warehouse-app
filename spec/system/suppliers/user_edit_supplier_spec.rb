require 'rails_helper'

describe 'usuário clica em link para editar fornecedor' do
  it 'na página de detalhes do fornecedor e vê formulário preenchido' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'BRASILINHA'
    click_on 'Editar fornecedor'

    expect(page).to have_field('Razão Social', with: 'BSB LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'BRASILINHA')
    expect(page).to have_field('CNPJ', with: '00000000000001')
    expect(page).to have_field('Endereço', with: 'qnd 03 lote 22')
    expect(page).to have_field('Cidade', with: 'Taguatinga')
    expect(page).to have_field('Estado', with: 'Distrito Federal')
    expect(page).to have_field('E-mail', with: 'bsb@bsb.com')
  end

  it 'vê formulário preenchido e edita com sucesso o fornecedor' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'BRASILINHA'
    click_on 'Editar fornecedor'

    fill_in 'Razão Social', with: 'GO LTDA'
    fill_in 'Nome Fantasia', with: 'GOIANINHA'
    fill_in 'CNPJ', with: '00000000000002'
    fill_in 'Endereço', with: 'Serrinha, 1000'
    fill_in 'Cidade', with: 'bairro da boa vista'
    fill_in 'Estado', with: 'Goiás'
    fill_in 'E-mail', with: 'go@go.com'
    click_on 'Salvar fornecedor'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'GO LTDA'
    expect(page).to have_content 'GOIANINHA'
    expect(page).to have_content 'CNPJ: 00000000000002'
    expect(page).to have_content 'Serrinha, 1000'
    expect(page).to have_content 'bairro da boa vista'
    expect(page).to have_content 'Goiás'
    expect(page).to have_content 'E-mail: go@go.com'
  end

  it 'vê formulário e edita sem sucesso o fornecedor' do
    Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

    visit root_path
    within ('nav') do
      click_on 'Fornecedores'
    end
    click_on 'BRASILINHA'
    click_on 'Editar fornecedor'

    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Salvar fornecedor'

    expect(page).to have_content 'Erro ao atualizar fornecedor'
  end
end