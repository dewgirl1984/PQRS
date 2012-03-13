class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :description
      t.references :user

      t.timestamps
    end
    add_foreign_key(:collections, :users)
  end
end
