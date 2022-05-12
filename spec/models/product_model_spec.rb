require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context  'presence' do
      it 'retorna falso quando o nome estiver em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando peso estiver em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a largura esta em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a altura esta em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando a profundidade estiver em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o código sku esta em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end

      it 'retorna falso quando o supplier esta em branco' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: nil)

        result = pm.valid?

        expect(result).to be_falsey
      end

    end

    context 'uniqueness' do
      it 'retorna falso quando o código sku está em uso' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        supplier2 = Supplier.create!(corporate_name: 'BSB2 LTDA', brand_name: 'BRAASILINHA', registration_number: '00000000000002', full_address: 'qnd 03 lote 23', city: 'Taguatinga2', state: 'Distrito Federal', email: 'bsb@bsb.com')

        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        pm = ProductModel.new(name: 'TV 33', weight: 9000, width: 60, height: 55, depth: 20, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier2)

        result = pm.valid?

        expect(result).to be_falsey
      end
    end

    context 'length' do
      it 'retorna falso quando o tamanho do código SKU é menor que 20' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO9000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey        
      end

      it 'retorna falso quando o tamanho do código SKU é maior que 20' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO900000', supplier: supplier)

        result = pm.valid?

        expect(result).to be_falsey
      end
    end

    context 'greater_than' do
      it 'retorna falso quando o peso é menor ou igual a 0' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: -1, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm2 = ProductModel.new(name: 'TV 33', weight: 0, width: 60, height: 55, depth: 20, sku: 'TV32-SAMSU-XPTO90001', supplier: supplier)

        result = ''

        if pm.valid? || pm2.valid?
          result = true
        else
          result = false 
        end

        expect(result).to be_falsey
      end

      it 'retorna falso quando a largura é menor ou igual a 0' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 70, width: 0, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm2 = ProductModel.new(name: 'TV 33', weight: 50, width: -1, height: 55, depth: 20, sku: 'TV32-SAMSU-XPTO90001', supplier: supplier)

        result = ''

        if pm.valid? || pm2.valid?
          result = true
        else
          result = false 
        end

        expect(result).to be_falsey
      end

      it 'retorna falso quando a altura é menor ou igual a 0' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 70, width: 70, height: 0, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm2 = ProductModel.new(name: 'TV 33', weight: 50, width: 60, height: -1, depth: 20, sku: 'TV32-SAMSU-XPTO90001', supplier: supplier)

        result = ''

        if pm.valid? || pm2.valid?
          result = true
        else
          result = false 
        end

        expect(result).to be_falsey
      end

      it 'retorna falso quando a profundidade for menor ou igual a 0' do
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        pm = ProductModel.new(name: 'TV 32', weight: 70, width: 70, height: 45, depth: -1, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm2 = ProductModel.new(name: 'TV 33', weight: 50, width: 60, height: 55, depth: 0, sku: 'TV32-SAMSU-XPTO90001', supplier: supplier)

        result = ''

        if pm.valid? || pm2.valid?
          result = true
        else
          result = false 
        end

        expect(result).to be_falsey
      end


    end

  end
end
