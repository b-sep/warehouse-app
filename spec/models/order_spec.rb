require 'rails_helper'

RSpec.describe Order, type: :model do
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
  end
end
