require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'retorna falso quando a Razão Social esta em branco' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?
        
        expect(result).to be_falsey
      end

      it 'retorna falso quando Nome Fantasia esta em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: '', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o CNPJ esta em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o Endereço estiver em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: '', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a Cidade estiver em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: '', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o Estado estiver em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: '', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o E-mail estiver em branco' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: '')

        result = supplier.valid?

        expect(result).to be_falsey
      end
    end

    context 'uniqueness' do
      it 'retorna falso quando o CNPJ ja esta em uso' do
        Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end
    end

    context 'length' do
      it 'retorna falso quando o tamanho do CNPJ é menor que 14 caracteres' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '0000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o tamanho do CNPJ é maior que 14 caracteres' do
        supplier = Supplier.new(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '000000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        result = supplier.valid?

        expect(result).to be_falsey
      end
    end
  end
end
