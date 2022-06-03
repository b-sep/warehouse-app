require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    context  'presence' do
      it 'falso se quantidade estiver em branco' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
          registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

          product_1 = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
            height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)

          warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
              address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

          order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

          oi = OrderItem.new(product_model: product_1, order: order, quantity: '')
          oi.valid?
          expect(oi.errors[:quantity]).to include 'não pode ficar em branco'
      end

      it 'falso se quantidade não for um número' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
          registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

          product_1 = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
            height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)

          warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
              address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

          order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

          oi = OrderItem.new(product_model: product_1, order: order, quantity: 'B')
          oi.valid?
          expect(oi.errors[:quantity]).to include 'não é um número'
      end

      it 'falso se a quantidade for igual a 0' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
          registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        product_1 = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
          height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)

        warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
            address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

        order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        oi = OrderItem.new(product_model: product_1, order: order, quantity: '0')
        oi.valid?
        expect(oi.errors[:quantity]).to include 'deve ser maior que 0'
      end

      it 'falso se a quantidade for menor que 0' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', 
          registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

        product_1 = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, 
          height: 25, depth: 10, sku: 'TVZC1234569932501811', supplier: supplier)

        warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
            address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

        order = Order.create!(user: user,  warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        oi = OrderItem.new(product_model: product_1, order: order, quantity: '-1')
        oi.valid?
        expect(oi.errors[:quantity]).to include 'deve ser maior que 0'
      end
    end
  end
end
