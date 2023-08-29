# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "application", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "key", limit: 64, null: false
    t.text "context_template"
    t.text "summary_template"
    t.text "sample_context"
    t.text "mobile_template"
    t.boolean "auth_only", default: false
    t.boolean "allow_other_app_incidents", default: false, null: false, unsigned: true
    t.boolean "allow_authenticating_users", default: false, null: false, unsigned: true
    t.string "secondary_key", limit: 64
    t.index ["name"], name: "name_idx", unique: true
  end

  create_table "application_custom_sender_address", primary_key: ["application_id", "mode_id"], charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "mode_id", null: false
    t.string "sender_address", null: false
    t.index ["mode_id"], name: "application_custom_sender_address_mode_id_ibfk"
  end

  create_table "application_mode", primary_key: ["application_id", "mode_id"], charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "mode_id", null: false
    t.index ["mode_id"], name: "application_mode_mode_id_ibfk"
  end

  create_table "application_owner", primary_key: ["application_id", "user_id"], charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "application_owner_user_id_ibfk"
  end

  create_table "application_quota", primary_key: "application_id", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.integer "hard_quota_threshold", limit: 2, null: false
    t.integer "soft_quota_threshold", limit: 2, null: false
    t.integer "hard_quota_duration", limit: 2, null: false
    t.integer "soft_quota_duration", limit: 2, null: false
    t.string "plan_name"
    t.bigint "target_id"
    t.integer "wait_time", limit: 2, default: 0, null: false
    t.index ["plan_name"], name: "application_quota_plan_name_fk_idx"
    t.index ["target_id"], name: "application_quota_target_id_fk_idx"
  end

  create_table "application_stats", primary_key: ["application_id", "statistic", "timestamp"], charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.string "statistic", null: false
    t.float "value"
    t.datetime "timestamp", precision: nil, null: false
  end

  create_table "category_override", primary_key: ["user_id", "category_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.integer "mode_id", null: false
    t.index ["category_id"], name: "category_override_category_id_ibfk"
    t.index ["mode_id"], name: "category_override_mode_id_ibfk"
  end

  create_table "comment", charset: "latin1", force: :cascade do |t|
    t.bigint "incident_id", null: false
    t.datetime "created", precision: nil, null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.index ["incident_id"], name: "comment_incident_id_ibfk"
    t.index ["user_id"], name: "comment_user_id_ibfk"
  end

  create_table "default_application_mode", primary_key: ["application_id", "priority_id"], charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "priority_id", null: false
    t.integer "mode_id", null: false
    t.index ["application_id"], name: "default_application_mode_ibfk_1"
    t.index ["mode_id"], name: "default_application_mode_ibfk_3"
    t.index ["priority_id"], name: "default_application_mode_ibfk_2"
  end

  create_table "device", charset: "latin1", force: :cascade do |t|
    t.string "registration_id", null: false
    t.bigint "user_id", null: false
    t.string "platform", null: false
    t.index ["registration_id"], name: "registration_id", unique: true
    t.index ["user_id"], name: "device_user_id_ibfk"
  end

  create_table "dynamic_plan_map", primary_key: ["incident_id", "dynamic_index"], charset: "latin1", force: :cascade do |t|
    t.bigint "incident_id", null: false, auto_increment: true
    t.integer "dynamic_index", null: false
    t.integer "role_id", null: false
    t.bigint "target_id", null: false
    t.index ["incident_id"], name: "ix_dynamic_plan_map_incident_id"
    t.index ["role_id"], name: "dynamic_plan_map_ibfk_2"
    t.index ["target_id"], name: "dynamic_plan_map_ibfk_1"
  end

  create_table "generic_message_sent_status", primary_key: "message_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.boolean "status", null: false
  end

  create_table "global_stats", primary_key: ["statistic", "timestamp"], charset: "latin1", force: :cascade do |t|
    t.string "statistic", null: false
    t.float "value"
    t.datetime "timestamp", precision: nil, null: false
  end

  create_table "incident", charset: "latin1", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.datetime "created", precision: nil, null: false
    t.datetime "updated", precision: nil
    t.text "context"
    t.bigint "owner_id"
    t.integer "application_id", null: false
    t.integer "current_step", null: false
    t.boolean "active", null: false
    t.boolean "resolved", default: false, null: false, unsigned: true
    t.index ["active"], name: "ix_incident_active"
    t.index ["application_id"], name: "ix_incident_application_id"
    t.index ["created"], name: "ix_incident_created"
    t.index ["owner_id"], name: "ix_incident_owner_id"
    t.index ["plan_id"], name: "ix_incident_plan_id"
    t.index ["updated"], name: "ix_incident_updated"
  end

  create_table "incident_emails", primary_key: "email", id: :string, charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.string "plan_name", null: false
    t.index ["application_id"], name: "incident_emails_application_id_fk_idx"
    t.index ["plan_name"], name: "incident_emails_plan_name_fk_idx"
  end

  create_table "mailing_list", primary_key: "target_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.bigint "count", default: 0, null: false
  end

  create_table "mailing_list_membership", primary_key: ["list_id", "user_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "mailing_list_membership_user_id_ibfk"
  end

  create_table "message", charset: "latin1", force: :cascade do |t|
    t.string "batch", limit: 32
    t.datetime "created", precision: nil, null: false
    t.datetime "sent", precision: nil
    t.integer "application_id", null: false
    t.bigint "target_id", null: false
    t.string "destination"
    t.integer "mode_id"
    t.bigint "plan_id"
    t.integer "priority_id", null: false
    t.string "subject"
    t.text "body"
    t.bigint "incident_id"
    t.bigint "plan_notification_id"
    t.boolean "active", default: true, null: false
    t.integer "template_id"
    t.index ["active"], name: "ix_message_active"
    t.index ["application_id"], name: "ix_message_application_id"
    t.index ["batch"], name: "ix_message_batch"
    t.index ["created"], name: "ix_message_created"
    t.index ["incident_id"], name: "ix_message_incident_id"
    t.index ["mode_id"], name: "ix_message_mode_id"
    t.index ["plan_id"], name: "plan_id"
    t.index ["plan_notification_id"], name: "ix_message_plan_notification_id"
    t.index ["priority_id"], name: "ix_message_priority_id"
    t.index ["sent"], name: "ix_message_sent"
    t.index ["target_id"], name: "ix_message_target_id"
    t.index ["template_id"], name: "message_ibfk_8"
  end

  create_table "message_changelog", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "date", precision: nil, null: false
    t.bigint "message_id", null: false
    t.string "change_type", null: false
    t.string "old", null: false
    t.string "new", null: false
    t.string "description"
    t.index ["date"], name: "ix_message_changelog_date"
    t.index ["message_id"], name: "ix_message_changelog_message_id"
  end

  create_table "mode", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "name_idx", unique: true
  end

  create_table "mode_template_override", primary_key: "target_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.integer "mode_id", null: false
    t.index ["mode_id"], name: "mode_id_override_ibfk_1"
  end

  create_table "notification_category", charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.integer "mode_id", null: false
    t.index ["application_id", "name"], name: "application_id", unique: true
    t.index ["application_id"], name: "ix_notification_category_app_id"
    t.index ["mode_id"], name: "notification_category_mode_id_ibfk"
  end

  create_table "oncall_team", primary_key: "target_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.bigint "oncall_team_id", null: false
    t.index ["oncall_team_id"], name: "oncall_team_id_idx", unique: true
  end

  create_table "plan", charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created", precision: nil, null: false
    t.bigint "user_id", null: false
    t.bigint "team_id"
    t.text "description"
    t.integer "step_count", null: false
    t.bigint "threshold_window"
    t.bigint "threshold_count"
    t.bigint "aggregation_window"
    t.bigint "aggregation_reset"
    t.string "tracking_key"
    t.string "tracking_type"
    t.text "tracking_template"
    t.index ["created"], name: "ix_plan_created"
    t.index ["team_id"], name: "team_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "plan_active", primary_key: "name", id: :string, charset: "latin1", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.index ["plan_id"], name: "plan_id", unique: true
  end

  create_table "plan_notification", charset: "latin1", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.integer "step", null: false
    t.string "template"
    t.bigint "target_id"
    t.boolean "optional", default: false, null: false
    t.integer "role_id"
    t.integer "priority_id", null: false
    t.integer "repeat", default: 0, null: false
    t.integer "wait", default: 0, null: false
    t.integer "dynamic_index"
    t.index ["plan_id"], name: "ix_plan_notification_plan_id"
    t.index ["priority_id"], name: "ix_plan_notification_priority_id"
    t.index ["role_id"], name: "ix_plan_notification_role_id"
    t.index ["target_id"], name: "ix_plan_notification_target_id"
    t.index ["template"], name: "ix_plan_notification_template"
  end

  create_table "priority", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "mode_id", null: false
    t.index ["mode_id"], name: "ix_priority_mode_id"
    t.index ["name"], name: "name_idx", unique: true
  end

  create_table "response", charset: "latin1", force: :cascade do |t|
    t.datetime "created", precision: nil, null: false
    t.bigint "message_id", null: false
    t.text "content", null: false
    t.string "source", null: false
    t.index ["created"], name: "ix_response_created"
    t.index ["message_id"], name: "ix_response_message_id"
  end

  create_table "target", charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "type_id", null: false
    t.boolean "active", default: true, null: false
    t.index ["active"], name: "active_index"
    t.index ["name", "type_id"], name: "name_type_idx", unique: true
    t.index ["type_id"], name: "target_ibfk_1"
  end

  create_table "target_application_mode", primary_key: ["target_id", "application_id", "priority_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "target_id", null: false
    t.integer "application_id", null: false
    t.integer "priority_id", null: false
    t.integer "mode_id", null: false
    t.index ["application_id"], name: "application_mode_ibfk_2"
    t.index ["mode_id"], name: "application_mode_ibfk_4"
    t.index ["priority_id"], name: "application_mode_ibfk_3"
  end

  create_table "target_contact", primary_key: ["target_id", "mode_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "target_id", null: false
    t.integer "mode_id", null: false
    t.string "destination", null: false
    t.index ["mode_id"], name: "ix_target_contact_mode_id"
  end

  create_table "target_mode", primary_key: ["target_id", "priority_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "target_id", null: false
    t.integer "priority_id", null: false
    t.integer "mode_id", null: false
    t.index ["mode_id"], name: "ix_target_mode_mode_id"
    t.index ["priority_id"], name: "priority_id"
  end

  create_table "target_reprioritization", primary_key: ["target_id", "src_mode_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "target_id", null: false
    t.integer "src_mode_id", null: false
    t.integer "dst_mode_id", null: false
    t.integer "count", limit: 1, null: false, unsigned: true
    t.integer "duration", limit: 2, null: false, unsigned: true
    t.index ["dst_mode_id"], name: "target_reprioritization_mode_dst_mode_id_fk_idx"
    t.index ["src_mode_id"], name: "target_reprioritization_mode_src_mode_id_fk_idx"
  end

  create_table "target_role", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "type_id", null: false
    t.index ["name"], name: "name_idx", unique: true
    t.index ["type_id"], name: "ix_target_role_type_id"
  end

  create_table "target_type", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "team", primary_key: "target_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.bigint "manager_id"
    t.bigint "director_id"
    t.index ["director_id"], name: "director_id"
    t.index ["manager_id"], name: "manager_id"
    t.index ["target_id"], name: "target_id", unique: true
  end

  create_table "template", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created", precision: nil, null: false
    t.bigint "user_id", null: false
    t.index ["created"], name: "ix_template_created"
    t.index ["name"], name: "ix_template_name"
    t.index ["user_id"], name: "ix_template_user_id"
  end

  create_table "template_active", primary_key: "name", id: :string, charset: "latin1", force: :cascade do |t|
    t.integer "template_id", null: false
    t.index ["template_id"], name: "template_id", unique: true
  end

  create_table "template_content", primary_key: ["template_id", "application_id", "mode_id"], charset: "latin1", force: :cascade do |t|
    t.integer "template_id", null: false
    t.integer "application_id", null: false
    t.integer "mode_id", null: false
    t.string "subject", null: false
    t.text "body", null: false
    t.text "call"
    t.text "sms"
    t.text "im"
    t.string "email_subject"
    t.text "email_text"
    t.text "email_html"
    t.index ["application_id"], name: "ix_template_content_application_id"
    t.index ["mode_id"], name: "ix_template_content_mode_id"
    t.index ["template_id"], name: "ix_template_content_template_id"
  end

  create_table "template_variable", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "application_id", null: false
    t.string "name", null: false
    t.boolean "required", default: false, null: false
    t.boolean "title_variable", default: false, null: false
    t.index ["application_id"], name: "ix_template_variable_application_id"
  end

  create_table "twilio_delivery_status", primary_key: "twilio_sid", id: { type: :string, limit: 34 }, charset: "latin1", force: :cascade do |t|
    t.bigint "message_id"
    t.string "status", limit: 30
    t.index ["message_id"], name: "twilio_delivery_status_message_id_fk_idx"
  end

  create_table "twilio_retry", primary_key: "message_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.bigint "retry_id", null: false
    t.index ["retry_id"], name: "twilio_retry_retry_id_fk_idx"
  end

  create_table "user", primary_key: "target_id", id: :bigint, default: nil, charset: "latin1", force: :cascade do |t|
    t.boolean "admin", default: false, null: false, unsigned: true
  end

  create_table "user_setting", primary_key: ["user_id", "name"], charset: "latin1", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "value", null: false
  end

  create_table "user_team", primary_key: ["user_id", "team_id"], charset: "latin1", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.index ["team_id"], name: "ix_user_team_team_id"
  end

  add_foreign_key "application_custom_sender_address", "application", name: "application_custom_sender_address_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_custom_sender_address", "mode", name: "application_custom_sender_address_mode_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_mode", "application", name: "application_mode_application_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_mode", "mode", name: "application_mode_mode_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_owner", "application", name: "application_owner_application_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_owner", "user", primary_key: "target_id", name: "application_owner_user_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_quota", "application", name: "application_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "application_quota", "plan_active", column: "plan_name", primary_key: "name", name: "plan_name_ibfk", on_update: :cascade, on_delete: :nullify
  add_foreign_key "application_quota", "target", name: "target_id_ibfk", on_update: :nullify, on_delete: :nullify
  add_foreign_key "application_stats", "application", name: "application_stats_app_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "category_override", "mode", name: "category_override_mode_id_ibfk"
  add_foreign_key "category_override", "notification_category", column: "category_id", name: "category_override_category_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "category_override", "user", primary_key: "target_id", name: "category_override_user_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "comment", "incident", name: "comment_incident_id_ibfk"
  add_foreign_key "comment", "user", primary_key: "target_id", name: "comment_user_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "default_application_mode", "application", name: "default_application_mode_ibfk_1"
  add_foreign_key "default_application_mode", "mode", name: "default_application_mode_ibfk_3"
  add_foreign_key "default_application_mode", "priority", name: "default_application_mode_ibfk_2"
  add_foreign_key "device", "user", primary_key: "target_id", name: "device_user_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dynamic_plan_map", "incident", name: "dynamic_plan_map_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dynamic_plan_map", "target", name: "dynamic_plan_map_ibfk_1"
  add_foreign_key "dynamic_plan_map", "target_role", column: "role_id", name: "dynamic_plan_map_ibfk_2"
  add_foreign_key "generic_message_sent_status", "message", name: "generic_message_sent_status_message_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "incident_emails", "application", name: "incident_emails_application_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "incident_emails", "plan_active", column: "plan_name", primary_key: "name", name: "incident_emails_plan_name_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mailing_list", "target", name: "mailing_list_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mailing_list_membership", "mailing_list", column: "list_id", primary_key: "target_id", name: "mailing_list_membership_list_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mailing_list_membership", "user", primary_key: "target_id", name: "mailing_list_membership_user_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "message_changelog", "message", name: "message_changelog_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mode_template_override", "mode", name: "mode_id_override_ibfk_1"
  add_foreign_key "mode_template_override", "target", name: "target_id_override_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notification_category", "application", name: "notification_category_app_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notification_category", "mode", name: "notification_category_mode_id_ibfk"
  add_foreign_key "oncall_team", "target", name: "oncall_team_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "plan", "team", primary_key: "target_id", name: "plan_ibfk_2"
  add_foreign_key "plan", "user", primary_key: "target_id", name: "plan_ibfk_1"
  add_foreign_key "plan_active", "plan", name: "plan_active_ibfk_1"
  add_foreign_key "plan_notification", "plan", name: "plan_notification_ibfk_1"
  add_foreign_key "plan_notification", "priority", name: "plan_notification_ibfk_5"
  add_foreign_key "plan_notification", "target", name: "plan_notification_ibfk_3"
  add_foreign_key "plan_notification", "target_role", column: "role_id", name: "plan_notification_ibfk_4"
  add_foreign_key "plan_notification", "template_active", column: "template", primary_key: "name", name: "plan_notification_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "priority", "mode", name: "priority_ibfk_1"
  add_foreign_key "response", "message", name: "response_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "target", "target_type", column: "type_id", name: "target_ibfk_1"
  add_foreign_key "target_application_mode", "application", name: "target_application_mode_ibfk_2"
  add_foreign_key "target_application_mode", "mode", name: "target_application_mode_ibfk_4"
  add_foreign_key "target_application_mode", "priority", name: "target_application_mode_ibfk_3"
  add_foreign_key "target_application_mode", "target", name: "target_application_mode_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "target_contact", "mode", name: "target_contact_ibfk_2"
  add_foreign_key "target_contact", "target", name: "target_contact_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "target_mode", "mode", name: "target_mode_ibfk_3"
  add_foreign_key "target_mode", "priority", name: "target_mode_ibfk_2"
  add_foreign_key "target_mode", "target", name: "target_mode_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "target_reprioritization", "mode", column: "dst_mode_id", name: "target_reprioritization_mode_dst_mode_id_fk"
  add_foreign_key "target_reprioritization", "mode", column: "src_mode_id", name: "target_reprioritization_mode_src_mode_id_fk"
  add_foreign_key "target_reprioritization", "target", name: "target_reprioritization_target_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "target_role", "target_type", column: "type_id", name: "target_role_ibfk_1"
  add_foreign_key "team", "target", name: "team_ibfk_1"
  add_foreign_key "team", "user", column: "director_id", primary_key: "target_id", name: "team_ibfk_3"
  add_foreign_key "team", "user", column: "manager_id", primary_key: "target_id", name: "team_ibfk_2"
  add_foreign_key "template", "user", primary_key: "target_id", name: "template_ibfk_1"
  add_foreign_key "template_active", "template", name: "template_active_ibfk_1"
  add_foreign_key "template_content", "application", name: "template_content_ibfk_2"
  add_foreign_key "template_content", "mode", name: "template_content_ibfk_3"
  add_foreign_key "template_content", "template", name: "template_content_ibfk_1"
  add_foreign_key "template_variable", "application", name: "template_variable_ibfk_1"
  add_foreign_key "twilio_delivery_status", "message", name: "twilio_delivery_status_message_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "twilio_retry", "message", name: "twilio_retry_message_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "twilio_retry", "message", name: "twilio_retry_retry_id_ibfk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user", "target", name: "user_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_setting", "target", column: "user_id", name: "user_setting_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_team", "team", primary_key: "target_id", name: "user_team_ibfk_2"
  add_foreign_key "user_team", "user", primary_key: "target_id", name: "user_team_ibfk_1"
end
