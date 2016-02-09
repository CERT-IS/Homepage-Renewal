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

ActiveRecord::Schema.define(version: 20160209062206) do

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
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "board_type_id", limit: 4
    t.integer  "share_counts",  limit: 4,          default: 0
    t.integer  "label_id",      limit: 4
    t.boolean  "isopen",        limit: 1,          default: true
  end

  add_index "boards", ["board_type_id"], name: "index_boards_on_board_type_id", using: :btree
  add_index "boards", ["label_id"], name: "index_boards_on_label_id", using: :btree
  add_index "boards", ["user_id"], name: "index_boards_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "board_id",   limit: 4
    t.text     "contents",   limit: 65535
    t.integer  "comment_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["board_id"], name: "index_comments_on_board_id", using: :btree
  add_index "comments", ["comment_id"], name: "index_comments_on_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",        limit: 255,                   null: false
    t.datetime "start_day",                                  null: false
    t.string   "start_time",   limit: 255
    t.datetime "end_day",                                    null: false
    t.string   "end_time",     limit: 255
    t.boolean  "start_allday", limit: 1,     default: false
    t.boolean  "end_allday",   limit: 1,     default: false
    t.string   "location",     limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "board_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["board_id"], name: "index_likes_on_board_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "keyword",     limit: 255
    t.boolean  "rating1",     limit: 1,     default: true
    t.boolean  "rating2",     limit: 1,     default: false
    t.boolean  "rating3",     limit: 1,     default: false
    t.boolean  "rating4",     limit: 1,     default: false
    t.boolean  "rating5",     limit: 1,     default: false
    t.integer  "views",       limit: 4,     default: 0
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "shares", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "board_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "shares", ["board_id"], name: "index_shares_on_board_id", using: :btree
  add_index "shares", ["user_id"], name: "index_shares_on_user_id", using: :btree

  create_table "user_project_mappeds", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.boolean  "master",     limit: 1, default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "approval",   limit: 1, default: false
  end

  add_index "user_project_mappeds", ["project_id"], name: "index_user_project_mappeds_on_project_id", using: :btree
  add_index "user_project_mappeds", ["user_id"], name: "index_user_project_mappeds_on_user_id", using: :btree

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
    t.string   "nickname",               limit: 255
    t.string   "introduce",              limit: 255
    t.string   "twitter",                limit: 255, default: ""
    t.string   "facebook",               limit: 255, default: ""
    t.string   "github",                 limit: 255, default: ""
    t.string   "blog",                   limit: 255, default: ""
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["realname"], name: "index_users_on_realname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "boards", "board_types"
  add_foreign_key "boards", "labels"
  add_foreign_key "boards", "users"
  add_foreign_key "comments", "boards"
  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "boards"
  add_foreign_key "likes", "users"
  add_foreign_key "shares", "boards"
  add_foreign_key "shares", "users"
  add_foreign_key "user_project_mappeds", "projects"
  add_foreign_key "user_project_mappeds", "users"
end
