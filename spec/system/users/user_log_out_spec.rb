require 'rails_helper'

describe 'usuário se autentica ' do
  it 'e faz logout' do
    User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    within 'form' do
      fill_in 'E-mail', with: 'jr@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'ENTRAR'
    end
    within 'nav' do
      click_on 'Sair'
    end

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'jr@email.com'
  end
end