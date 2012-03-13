class Collection < ActiveRecord::Base
  has_many :qr_collection_placements, dependent: :destroy
  has_many :qrcodes, through: :qr_collection_placements
end
