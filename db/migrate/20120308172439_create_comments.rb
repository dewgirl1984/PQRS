class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :qrcode_id

      t.timestamps
    end
    add_index :comments, :qrcode_id
  end
end
