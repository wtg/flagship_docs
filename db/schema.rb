# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091214042617) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "private",           :default => false
    t.boolean  "writable",          :default => false
    t.integer  "parent_id"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "children_count"
    t.integer  "ancestors_count"
    t.integer  "descendants_count"
    t.integer  "position"
    t.integer  "pictures_count"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "readable",    :default => true
    t.boolean  "writable",    :default => false
    t.integer  "downloaded",  :default => 0
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "project_id"
  end

  create_table "revisions", :force => true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.binary   "upload_file",         :limit => 2147483647
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
