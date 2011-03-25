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

ActiveRecord::Schema.define(:version => 20110323002746) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_private",  :default => false
    t.boolean  "is_writable", :default => false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_private",  :default => false
    t.boolean  "is_writable", :default => false
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revisions", :force => true do |t|
    t.integer  "document_id"
    t.text     "search_text"
    t.integer  "download_count",                    :default => 0
    t.string   "file_name"
    t.string   "file_type"
    t.integer  "file_size"
    t.binary   "file_data",      :limit => 4194304
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
