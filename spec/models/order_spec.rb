require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'retorna true se gerar código' do
      user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
      supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-06-01')

      expect(order.valid?).to be true
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
      supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-06-01')
      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.size).to eq 10
    end

    it 'e o código é único' do
      user = User.create!(name: 'Júnior', email: 'jr@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                                    address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')
      supplier = Supplier.create!(corporate_name: 'BSB LTDA', brand_name: 'BRASILINHA', registration_number: '00000000000001', full_address: 'qnd 03 lote 22', city: 'Taguatinga', state: 'Distrito Federal', email: 'bsb@bsb.com')

      order_1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-06-01')
      order_2 = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-07-22')
      order_2.save!
           
      expect(order_2.code).not_to eq order_1.code
    end
  end
end
