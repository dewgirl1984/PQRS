class AddQrcodeIdFkToComments < ActiveRecord::Migration
  def up
    add_foreign_key(:comments, :qrcodes)
  end
  def down
    remove_foreign_key(:comments, :qrcodes)
  end
end
