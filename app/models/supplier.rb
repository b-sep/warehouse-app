class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }

  def full_description
    "#{self.brand_name} - #{self.registration_number}"
  end
end
