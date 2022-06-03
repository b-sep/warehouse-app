class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :quantity, numericality: true
  validates :quantity, presence: true
end
