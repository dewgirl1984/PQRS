# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120308235450) do

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "collections", ["user_id"], :name => "collections_user_id_fk"

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "qrcode_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["qrcode_id"], :name => "index_comments_on_qrcode_id"

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true, :length => {"token"=>767}

  create_table "contents", :force => true do |t|
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "qr_collection_placements", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "qrcode_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "qr_collection_placements", ["collection_id"], :name => "index_qr_collection_placements_on_collection_id"
  add_index "qr_collection_placements", ["qrcode_id"], :name => "index_qr_collection_placements_on_qrcode_id"

  create_table "qr_content_placements", :force => true do |t|
    t.integer  "qrcontent_id"
    t.integer  "qrcode_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "qr_content_placements", ["qrcode_id"], :name => "index_qr_content_placements_on_qrcode_id"
  add_index "qr_content_placements", ["qrcontent_id"], :name => "index_qr_content_placements_on_qrcontent_id"

  create_table "qrcodes", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.integer  "hits"
    t.float    "geoLong"
    t.float    "geoLat"
    t.binary   "image"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "qrcodes", ["user_id"], :name => "qrcodes_user_id_fk"

  create_table "qrcontents", :force => true do |t|
    t.string   "url"
    t.integer  "content_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "qrcontents", ["content_id"], :name => "index_qrcontents_on_content_id"

  create_table "users", :force => true do |t|
    t.string   "uuid"
    t.string   "email",      :null => false
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_foreign_key "collections", "users", :name => "collections_user_id_fk", :dependent => :delete

  add_foreign_key "comments", "qrcodes", :name => "comments_qrcode_id_fk", :dependent => :delete

  add_foreign_key "qr_collection_placements", "collections", :name => "qr_collection_placements_collection_id_fk", :dependent => :delete
  add_foreign_key "qr_collection_placements", "qrcodes", :name => "qr_collection_placements_qrcode_id_fk", :dependent => :delete

  add_foreign_key "qr_content_placements", "qrcodes", :name => "qr_content_placements_qrcode_id_fk"
  add_foreign_key "qr_content_placements", "qrcontents", :name => "qr_content_placements_qrcontent_id_fk"

  add_foreign_key "qrcodes", "users", :name => "qrcodes_user_id_fk", :dependent => :delete

  add_foreign_key "qrcontents", "contents", :name => "qrcontents_content_id_fk"

end
