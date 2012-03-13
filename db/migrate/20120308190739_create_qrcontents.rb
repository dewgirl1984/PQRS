class CreateQrcontents < ActiveRecord::Migration
  def change
    create_table :qrcontents do |t|
      t.string :url
      t.references :content

      t.timestamps
    end
    add_index :qrcontents, :content_id
    add_foreign_key(:qrcontents, :contents)
  end
end
