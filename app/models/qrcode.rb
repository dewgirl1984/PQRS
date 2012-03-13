class Qrcode < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :qr_collection_placements, dependent: :destroy
  has_many :collections, through: :qr_collection_placements
end
