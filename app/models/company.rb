class Company < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :integration_settings, dependent: :destroy

  validates :fluid_shop, :authentication_token, :name, :fluid_company_id, :company_droplet_uuid, presence: true
  validates :authentication_token, uniqueness: true

  scope :active, -> { where(active: true) }
end
