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

ActiveRecord::Schema.define(version: 20150215071644) do

  create_table "addresses", force: true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "encrypted_first_name"
    t.text     "encrypted_last_name"
    t.text     "encrypted_street1"
    t.text     "encrypted_street2"
    t.text     "encrypted_city"
    t.text     "encrypted_state"
    t.text     "encrypted_zipcode"
    t.text     "encrypted_phone"
  end

  create_table "allergies", force: true do |t|
    t.string   "name",        default: "", null: false
    t.string   "description", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allergies", ["name"], name: "index_allergies_on_name", unique: true, using: :btree

  create_table "allergies_users", force: true do |t|
    t.integer "allergy_id"
    t.integer "user_id"
  end

  create_table "billings", force: true do |t|
    t.string   "token"
    t.string   "provider"
    t.string   "customer_id"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.string   "last_4"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "card_type"
    t.integer  "subscription_id"
    t.text     "encrypted_expiration_month"
    t.text     "encrypted_expiration_year"
    t.text     "encrypted_last_4"
    t.text     "encrypted_name"
    t.text     "encrypted_card_type"
    t.string   "card_number"
    t.text     "encrypted_card_number"
    t.string   "card_code"
    t.text     "encrypted_card_code"
  end

  add_index "billings", ["user_id"], name: "index_billings_on_user_id", unique: true, using: :btree

  create_table "bpo_processors", force: true do |t|
    t.datetime "last_sent"
    t.string   "email"
    t.integer  "order_id"
    t.integer  "last_sent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_id"
    t.integer  "store_id"
  end

  create_table "deliveries_orders", force: true do |t|
    t.integer "delivery_id"
    t.integer "order_id"
  end

  create_table "delivery_choices", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "delivery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_times", force: true do |t|
    t.date     "delivery_date"
    t.string   "time_slot"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delivery_zone_id"
  end

  create_table "delivery_zones", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "days"
    t.integer  "user_group_id"
    t.string   "restricted_times"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "unit",                               null: false
    t.string   "category"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",        default: 0,     null: false
    t.string   "price_currency",     default: "USD", null: false
    t.boolean  "pantry",             default: false, null: false
    t.string   "slug"
    t.string   "measurement_type"
    t.boolean  "cash_back",          default: false, null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "meal_plan_recipes", force: true do |t|
    t.string   "meal_type",    default: "lunch", null: false
    t.date     "meal_date",                      null: false
    t.boolean  "processed",                      null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.integer  "meal_plan_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_plans", force: true do |t|
    t.string   "plan_type",  default: "3-day", null: false
    t.boolean  "active",     default: true,    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measurement_conversions", force: true do |t|
    t.string   "measurement_type",                               default: "", null: false
    t.decimal  "measurement",           precision: 10, scale: 0, default: 0,  null: false
    t.string   "display_unit",                                   default: "", null: false
    t.string   "converted_measurement",                          default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_billings", force: true do |t|
    t.boolean  "charged",    default: false, null: false
    t.boolean  "updated",    default: false, null: false
    t.boolean  "canceled",   default: false, null: false
    t.string   "trans_id"
    t.integer  "order_id"
    t.integer  "billing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_billings", ["order_id"], name: "index_order_billings_on_order_id", unique: true, using: :btree

  create_table "order_confirmations", force: true do |t|
    t.integer  "order_id"
    t.string   "supplier"
    t.text     "raw_message"
    t.datetime "send_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient"
  end

  create_table "order_portions", force: true do |t|
    t.float    "quantity",       default: 0.0,   null: false
    t.integer  "order_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.boolean  "include",        default: true,  null: false
  end

  create_table "order_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "price_cents"
    t.string   "price_currency", default: "USD", null: false
    t.boolean  "pantry"
    t.boolean  "cashback"
  end

  create_table "order_servings", force: true do |t|
    t.float    "quantity",   default: 0.0, null: false
    t.integer  "order_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_substitutions", force: true do |t|
    t.integer  "order_id",                      null: false
    t.string   "original_sku",                  null: false
    t.string   "substituted_confirmation_name", null: false
    t.string   "substituted_sku",               null: false
    t.string   "quantity",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.float    "price"
    t.boolean  "active",            default: true,  null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",       default: 0,     null: false
    t.string   "price_currency",    default: "USD", null: false
    t.integer  "delivery_site_id"
    t.datetime "scheduled_for"
    t.datetime "delivered_at"
    t.boolean  "delivered"
    t.boolean  "checked_out",       default: false, null: false
    t.integer  "shopping_cart_id"
    t.text     "comments"
    t.integer  "subtotal_cents",    default: 0,     null: false
    t.string   "subtotal_currency", default: "USD", null: false
    t.integer  "subscription_id"
  end

  add_index "orders", ["checked_out"], name: "index_orders_on_checked_out", using: :btree
  add_index "orders", ["delivered"], name: "index_orders_on_delivered", using: :btree
  add_index "orders", ["delivery_site_id"], name: "index_orders_on_delivery_site_id", using: :btree
  add_index "orders", ["scheduled_for"], name: "index_orders_on_scheduled_for", using: :btree

  create_table "orders_recipes", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "recipe_id"
  end

  create_table "orders_users", force: true do |t|
    t.integer "user_id"
    t.integer "order_id"
  end

  create_table "patientships", force: true do |t|
    t.integer  "patient_id",                     null: false
    t.integer  "practitioner_id",                null: false
    t.boolean  "active",          default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pricings", force: true do |t|
    t.integer  "min_serving", null: false
    t.integer  "max_serving", null: false
    t.integer  "price_cents", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "friendly_name"
    t.string   "brand_and_item"
    t.string   "sku"
    t.decimal  "amount",            precision: 10, scale: 2
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",                                                null: false
    t.string   "price_currency",                             default: "USD", null: false
    t.string   "sku_quantity"
    t.string   "confirmation_name"
    t.integer  "ingredient_id"
  end

  create_table "products_stores", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "store_id"
  end

  create_table "promos", force: true do |t|
    t.string   "code"
    t.date     "starts_on"
    t.date     "ends_on"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                     default: true
    t.integer  "discount_cents",                             default: 0,     null: false
    t.string   "discount_currency",                          default: "USD", null: false
    t.decimal  "discount_percent",  precision: 10, scale: 0
    t.integer  "max_utilization",                            default: 1,     null: false
    t.float    "min_order_price"
    t.float    "max_order_price"
    t.boolean  "auto_apply",                                 default: false, null: false
  end

  add_index "promos", ["code"], name: "index_promos_on_code", using: :btree

  create_table "questions", force: true do |t|
    t.string   "type"
    t.string   "category"
    t.text     "prompt"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_portions", force: true do |t|
    t.float    "quantity",                default: 0.0,  null: false
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "include",                 default: true, null: false
    t.string   "additional_instructions"
    t.integer  "order"
  end

  create_table "recipes", force: true do |t|
    t.string   "name",               default: "0",      null: false
    t.text     "preparation"
    t.text     "description"
    t.integer  "prep_time",          default: 0,        null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "nutrition"
    t.string   "slug"
    t.integer  "cook_time",          default: 0,        null: false
    t.boolean  "published",          default: false,    null: false
    t.string   "source",             default: "",       null: false
    t.string   "meal",               default: "dinner", null: false
    t.datetime "published_at"
    t.boolean  "is_new",             default: false,    null: false
  end

  add_index "recipes", ["meal"], name: "index_recipes_on_meal", using: :btree
  add_index "recipes", ["slug"], name: "index_recipes_on_slug", unique: true, using: :btree

  create_table "reimbursements", force: true do |t|
    t.integer  "discount_cents",                                default: 0,      null: false
    t.string   "discount_currency",                             default: "USD",  null: false
    t.decimal  "discount_percent",     precision: 10, scale: 0
    t.string   "recurrence_frequency",                          default: "none", null: false
    t.boolean  "active",                                        default: true,   null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_cart_items", force: true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.integer "quantity"
    t.integer "item_id"
    t.string  "item_type"
    t.float   "price"
  end

  create_table "shopping_carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "completed",  default: false
  end

  create_table "signup_inquiries", force: true do |t|
    t.string   "zipcode",     default: "", null: false
    t.string   "email",       default: "", null: false
    t.string   "invite_code", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_zipcodes", id: false, force: true do |t|
    t.integer "store_id"
    t.integer "zipcode_id"
    t.integer "load_percent",   default: 100, null: false
    t.text    "bpo_processors"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "store_password"
    t.string   "store_email"
    t.string   "store_website"
    t.string   "remote_printer_email"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "subscription_type",  default: "3-meal", null: false
    t.datetime "expires_on",                            null: false
    t.datetime "paused_on"
    t.datetime "resumes_on"
    t.string   "delivery_day",                          null: false
    t.string   "delivery_time_slot",                    null: false
    t.string   "status",             default: "active", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions_recipes", id: false, force: true do |t|
    t.integer "subscription_id"
    t.integer "recipe_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "used_promos", force: true do |t|
    t.integer  "promo_id"
    t.integer  "order_id"
    t.integer  "shopping_cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.string   "name",                              null: false
    t.integer  "user_count",            default: 0, null: false
    t.string   "code",                              null: false
    t.text     "welcome_greeting",                  null: false
    t.text     "delivery_instructions",             null: false
    t.string   "delivery_times"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "delivery_info_message"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                 default: "",    null: false
    t.string   "password_digest",                                       default: "",    null: false
    t.string   "first"
    t.string   "last"
    t.integer  "adults",                                                default: 1
    t.integer  "children",                                              default: 0
    t.string   "password_reset_token",                                  default: "",    null: false
    t.datetime "password_reset_sent_at"
    t.string   "role",                                                  default: "",    null: false
    t.boolean  "active",                                                default: false, null: false
    t.string   "auth_token",                                            default: "",    null: false
    t.boolean  "locked",                                                default: true,  null: false
    t.integer  "delivery_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "eligible",                                              default: false, null: false
    t.string   "zipcode",                                               default: ""
    t.boolean  "guest",                                                 default: false, null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "ok_to_email",                                           default: false
    t.integer  "user_group_id"
    t.string   "invite_code"
    t.decimal  "weight",                        precision: 5, scale: 2
    t.decimal  "height",                        precision: 2, scale: 1
    t.string   "practitioner_code"
    t.date     "dob"
    t.string   "gender"
    t.text     "dietary_profile"
    t.string   "certificate_number"
    t.string   "certificate_type"
    t.text     "encrypted_first"
    t.text     "encrypted_last"
    t.text     "encrypted_adults"
    t.text     "encrypted_children"
    t.text     "encrypted_invite_code"
    t.text     "encrypted_weight"
    t.text     "encrypted_height"
    t.text     "encrypted_practitioner_code"
    t.text     "encrypted_dob"
    t.text     "encrypted_gender"
    t.text     "encrypted_dietary_profile"
    t.text     "encrypted_certificate_number"
    t.text     "encrypted_certificate_type"
    t.text     "encrypted_zipcode"
    t.string   "insurer"
    t.string   "insurance_member_id"
    t.string   "encrypted_insurer"
    t.string   "encrypted_insurance_member_id"
    t.string   "business_name"
    t.string   "encrypted_business_name"
  end

  create_table "weekly_delivery_schedules", force: true do |t|
    t.string   "delivery_day"
    t.string   "time_slot"
    t.string   "delivery_instructions"
    t.integer  "subscription_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zipcodes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.integer  "delivery_zone_id"
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
