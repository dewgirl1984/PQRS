class Qrcode < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :qr_collection_placements, dependent: :destroy
  has_many :collections, through: :qr_collection_placements
  has_many :qr_content_placements, dependent: :destroy
  has_many :qrcontents, through: :qr_content_placements

  def get_url
    "http://srprog-sp12-01.cs.fiu.edu:3000/qrcodes/#{self.id}"
  end
end
