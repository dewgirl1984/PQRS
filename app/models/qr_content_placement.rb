class QrContentPlacement < ActiveRecord::Base
  belongs_to :qrcontent
  belongs_to :qrcode 
end
