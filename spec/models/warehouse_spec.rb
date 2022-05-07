require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do

    context 'presence' do
    
      it 'retorna falso quando o nome esta em branco' do

        warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o código esta em branco' do

        warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a cidade esta em branco' do
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: '', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a area esta em branco' do
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: '', address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o endereço esta em branco' do
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: '', zip_code: '70000-000', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o cep esta em branco' do
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '', description: 'Galpão carioca')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a descrição esta em branco' do
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: '')

        result = warehouse.valid?

        expect(result).to be_falsey
      end
    end

    context 'uniq' do
      it 'retorna falso quando o código do galpão já esta esta em uso' do
        Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')
   
        warehouse = Warehouse.new(name: 'Niterói', code: 'SDU', city: 'Niterói', area: 70_000, address: 'Galeão', zip_code: '72000-000', description: 'Galpão de Niterói')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o nome do galpão já esta em uso' do
        Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Santos Dumont', zip_code: '70000-000', description: 'Galpão carioca')

        warehouse = Warehouse.new(name: 'Rio', code: 'ABS', city: 'Niterói', area: 50_000, address: 'Galeão', zip_code: '80000-000', description: 'Galpão de Niterói')

        result = warehouse.valid?

        expect(result).to be_falsey
      end
    end

    context 'format' do
      it 'retorna falso quando o CEP não esta com a quantidade certa de números antes do -' do
        warehouse = Warehouse.new(name: 'Niterói', code: 'SDU', city: 'Niterói', area: 70_000, address: 'Galeão', zip_code: '000000-000', description: 'Galpão de Niterói')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o CEP não esta com a quantidade certa de números depois do -' do
        warehouse = Warehouse.new(name: 'Niterói', code: 'SDU', city: 'Niterói', area: 70_000, address: 'Galeão', zip_code: '77000-00', description: 'Galpão de Niterói')

        result = warehouse.valid?

        expect(result).to be_falsey
      end

    end

    context 'length' do
      it 'retorna falso quando o tamanho do código é diferente de 3 caracteres' do
        warehouse = Warehouse.new(name: 'Niterói', code: 'AAAA', city: 'Niterói', area: 70_000, address: 'Galeão', zip_code: '00000-000', description: 'Galpão de Niterói')

        result = warehouse.valid?

        expect(result).to be_falsey
      end
    end
  end
end
