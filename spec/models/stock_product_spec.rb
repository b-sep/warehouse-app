require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                    address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
      supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001',
                                  full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
      product_1 = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                       height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: :delivered)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_1)

      expect(stock_product.serial_number.size).to eq 20
    end

    it 'e não é modificado' do
      user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                    address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
      supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001',
                                  full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
      product_1 = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                       height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)
      product_2 = ProductModel.create!(name: 'Galaxy S20e', weight: 1, width: 15, 
                                       height: 30, depth: 5, sku: 'GL201234569932501811', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: :delivered)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_1)
      original_serial_number = stock_product.serial_number
      stock_product.update!(product_model: product_2)

      expect(stock_product.serial_number).to eq original_serial_number
    end
    
    describe '#available?' do
      it 'true se não tiver destino' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                      address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001',
                                    full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
        product_1 = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                        height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: :delivered)

        stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_1)

        expect(stock_product.available?).to eq true
      end

      it 'false se tiver destino' do
        user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                      address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
        supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001',
                                    full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')
        product_1 = ProductModel.create!(name: 'Galaxy S10e', weight: 1, width: 10, 
                                        height: 25, depth: 10, sku: 'GLXC1234569932501811', supplier: supplier)

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: :delivered)

        stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_1)
        stock_product.create_stock_product_destination!(recipient: 'Joao', address: 'Rua alvares')

        expect(stock_product.available?).to eq false
      end
    end

  end  
end
