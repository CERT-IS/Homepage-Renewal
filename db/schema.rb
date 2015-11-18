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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151118185230) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id",         limit: 4
    t.string   "attachable_type",       limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "contents_file_name",    limit: 255
    t.string   "contents_content_type", limit: 255
    t.integer  "contents_file_size",    limit: 4
    t.datetime "contents_updated_at"
  end

  create_table "board_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "realname",   limit: 255
  end

  create_table "boards", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.integer  "user_id",       limit: 4
    t.text     "contents",      limit: 4294967295
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "board_type_id", limit: 4
    t.integer  "share_counts",  limit: 4,          default: 0
  end

  add_index "boards", ["board_type_id"], name: "index_boards_on_board_type_id", using: :btree
  add_index "boards", ["user_id"], name: "index_boards_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "board_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["board_id"], name: "index_likes_on_board_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "board_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "shares", ["board_id"], name: "index_shares_on_board_id", using: :btree
  add_index "shares", ["user_id"], name: "index_shares_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "uid",                    limit: 255, default: "", null: false
    t.string   "realname",               limit: 255, default: "", null: false
    t.string   "phone",                  limit: 255, default: "", null: false
    t.string   "authentication_token",   limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["realname"], name: "index_users_on_realname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  add_foreign_key "boards", "board_types"
  add_foreign_key "boards", "users"
  add_foreign_key "likes", "boards"
  add_foreign_key "likes", "users"
  add_foreign_key "shares", "boards"
  add_foreign_key "shares", "users"
end
