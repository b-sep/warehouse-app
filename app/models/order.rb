class Order < ApplicationRecord
  before_validation :generate_code
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  private

  def generate_code
    code = self.code
    if code.nil?
      self.code = SecureRandom.alphanumeric(10).upcase
    else
      code
    end
  end
end
