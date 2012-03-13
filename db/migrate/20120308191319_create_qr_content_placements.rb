class CreateQrContentPlacements < ActiveRecord::Migration
  def change
    create_table :qr_content_placements do |t|
      t.references :qrcontent
      t.references :qrcode

      t.timestamps
    end
    add_index :qr_content_placements, :qrcontent_id
    add_index :qr_content_placements, :qrcode_id
    add_foreign_key(:qr_content_placements, :qrcontents)
    add_foreign_key(:qr_content_placements, :qrcodes)
  end
end
