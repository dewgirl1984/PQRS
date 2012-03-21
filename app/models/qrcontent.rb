class Qrcontent < ActiveRecord::Base
  has_many :qr_content_placements, dependent: :destroy
  has_many :qrcodes, through: :qr_content_placements
  has_one :content
end
