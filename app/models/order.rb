class Order < ApplicationRecord
  before_validation :generate_code
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  enum status: { pending: 0, delivered: 5, canceled: 10}, _default: :pending

  validates :estimated_delivery_date, :code, presence: true
  validate :estimated_delivery_date_is_future

  private

  def generate_code
    code = self.code
    if code.nil?
      self.code = SecureRandom.alphanumeric(10).upcase
    else
      code
    end
  end

  def estimated_delivery_date_is_future
    self.errors.add(:estimated_delivery_date, 'deve ser futura') if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
  end
end
