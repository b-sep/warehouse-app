class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :zip_code, :description, presence: true
  validates :code, length: { is: 3 }
  validates :code, :name, uniqueness: true
  validates :zip_code, format: { with: /\A\d{5}-\d{3}\z/ }
  has_many :stock_products

  def full_description
    "#{self.code} - #{self.name}"
  end
end
