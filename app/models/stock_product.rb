class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination
  before_validation :generate_serial_number

  def available?
    stock_product_destination.nil?
  end

  private

  def generate_serial_number
    serial_number = self.serial_number
    if serial_number.nil?
      self.serial_number = SecureRandom.alphanumeric(20).upcase
    else
      serial_number
    end
  end
  
end
