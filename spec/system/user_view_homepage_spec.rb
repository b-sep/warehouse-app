require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê nome da app' do
    #arrange
    #act
    visit root_path
    #assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    #arrange (preparação do teste)
    #cadastrar 2 galpões: Rio e Maceió
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000)
    Warehouse.create(name: 'Brasília', code: 'BSB', city: 'Brasília', area: 40_000)

    #act (ação do usuário)
    visit root_path

    #assert
    #garantir que eu vejo na tela os galpões Rio e Maceió e suas informações (nome, código, metragem e cidade)
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('50000 m2')

    expect(page).to have_content('Brasília')
    expect(page).to have_content('Código: BSB')
    expect(page).to have_content('Cidade: Brasília')
    expect(page).to have_content('40000 m2')

  end

  it 'nao existem galpões cadastrados' do
    #arrange

    #act
    visit root_path

    #assert
    expect(page).to have_content('Não existem galpões cadastrados')

  end
end
