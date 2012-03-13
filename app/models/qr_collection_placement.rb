class QrCollectionPlacement < ActiveRecord::Base
  belongs_to :collection
  belongs_to :qrcode
end
