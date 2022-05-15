require 'rails_helper'

describe 'visitante se cadastra' do
  it 'com sucesso' do

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    click_on 'Cadastre-se'
    fill_in 'Nome', with: 'João'
    fill_in 'E-mail', with: 'joao@bsb.com'
    fill_in 'Senha', with: '123teste'
    fill_in 'Confirme sua senha', with: '123teste'
    click_on 'CADASTRAR'
    
    expect(page).to have_content 'Cadastro criado com sucesso'
    expect(page).to have_content 'joao@bsb.com'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name). to eq 'João'
  end
end