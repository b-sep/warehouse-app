class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :stock_products

  def full_description
    "#{self.name} - #{self.sku}"
  end
end
