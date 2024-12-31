class Admin < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  validates :phone, format: { with: /\A\+?[\d\s-]{10,}\z/, message: "format is invalid" },
                   allow_blank: true

  validates :role_level, inclusion: { in: 0..5 }

  scope :active, -> { where(active_status: true) }
  scope :by_role, ->(level) { where(role_level: level) }

  def self.search(query)
    where("name LIKE ? OR email LIKE ?", "%#{query}%", "%#{query}%")
  end

  private

  def generate_admin_code
    "ADM-#{Time.current.to_i}"
  end
end
