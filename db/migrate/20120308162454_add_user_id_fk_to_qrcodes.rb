class AddUserIdFkToQrcodes < ActiveRecord::Migration
  def up
    add_foreign_key(:qrcodes, :users)
  end
  def down
    remove_foreign_key(:qrcodes, :users)
  end
end
