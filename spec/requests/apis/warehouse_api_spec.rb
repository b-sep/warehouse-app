require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Galpão Brasília', code: 'BSB', city: 'Brasília', area: 40_000, 
                        address: 'Santa-Maria', zip_code: '72000-000', description: 'Galpão destinado a toda região centro-oeste')

      get "/api/v1/warehouses/#{warehouse.id}"
      json_response = JSON.parse(response.body)

     
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response["id"]).to eq warehouse.id
      expect(json_response["name"]).to eq 'Galpão Brasília'
      expect(json_response["code"]).to eq 'BSB'
      expect(json_response["city"]).to eq 'Brasília'
      expect(json_response["area"]).to eq 40_000
      expect(json_response["address"]).to eq 'Santa-Maria'
      expect(json_response["zip_code"]).to eq '72000-000'
      expect(json_response["description"]).to eq 'Galpão destinado a toda região centro-oeste'
    end
  end
end