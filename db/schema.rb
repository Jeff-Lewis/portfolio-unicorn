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

ActiveRecord::Schema.define(version: 20130727152725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "exchanges", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exchanges", ["name"], name: "index_exchanges_on_name", unique: true, using: :btree

  create_table "industries", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "industries", ["name"], name: "index_industries_on_name", unique: true, using: :btree

  create_table "portfolios", force: true do |t|
    t.string   "name"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id", using: :btree

  create_table "positions", force: true do |t|
    t.integer  "portfolio_id",                       null: false
    t.integer  "security_id",                        null: false
    t.integer  "quantity",                           null: false
    t.integer  "avg_price_cents",                    null: false
    t.string   "avg_price_currency", default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["portfolio_id"], name: "index_positions_on_portfolio_id", using: :btree
  add_index "positions", ["security_id"], name: "index_positions_on_security_id", using: :btree

  create_table "sectors", force: true do |t|
    t.string   "name",        null: false
    t.integer  "industry_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sectors", ["industry_id", "name"], name: "index_sectors_on_industry_id_and_name", unique: true, using: :btree

  create_table "securities", force: true do |t|
    t.string   "symbol",                     null: false
    t.string   "name",                       null: false
    t.integer  "exchange_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: true, null: false
    t.integer  "sector_id",                  null: false
  end

  add_index "securities", ["exchange_id"], name: "index_securities_on_exchange_id", using: :btree
  add_index "securities", ["sector_id"], name: "index_securities_on_sector_id", using: :btree
  add_index "securities", ["symbol", "exchange_id"], name: "index_securities_on_symbol_and_exchange_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                            null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "portfolios", "users", :name => "portfolios_user_id_fk", :dependent => :delete

  add_foreign_key "positions", "portfolios", :name => "positions_portfolio_id_fk", :dependent => :delete
  add_foreign_key "positions", "securities", :name => "positions_security_id_fk", :dependent => :restrict

  add_foreign_key "sectors", "industries", :name => "sectors_industry_id_fk", :dependent => :delete

  add_foreign_key "securities", "exchanges", :name => "securities_exchange_id_fk", :dependent => :delete
  add_foreign_key "securities", "sectors", :name => "securities_sector_id_fk", :dependent => :nullify

end
