class CreateQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.string :name, null: false
      t.text :description
      t.integer :hits
      t.float :geoLong
      t.float :geoLat
      t.binary :image
      t.references :user

      t.timestamps
    end
  end
end
