require 'rails_helper'

describe 'usuário se autentica' do
  it 'com sucesso' do

    User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'E-mail', with: 'jr@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'ENTRAR'
    end

    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'jr@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
end