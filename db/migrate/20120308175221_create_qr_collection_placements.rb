class CreateQrCollectionPlacements < ActiveRecord::Migration
  def change
    create_table :qr_collection_placements do |t|
      t.references :collection
      t.references :qrcode

      t.timestamps
    end
    add_index :qr_collection_placements, :collection_id
    add_index :qr_collection_placements, :qrcode_id
    add_foreign_key(:qr_collection_placements, :collections)
    add_foreign_key(:qr_collection_placements, :qrcodes)

  end
end
