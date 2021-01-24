class InitSchema < ActiveRecord::Migration[6.0]
  def up
    create_table "action_text_rich_texts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false
      t.text "body", size: :long
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
    end
    create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
    create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
    create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.text "content"
      t.bigint "user_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "title"
      t.string "thumbnail"
      t.index ["user_id", "created_at"], name: "index_articles_on_user_id_and_created_at"
      t.index ["user_id"], name: "index_articles_on_user_id"
    end
    create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.bigint "article_id", null: false
      t.string "content"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["article_id"], name: "index_comments_on_article_id"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end
    create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.bigint "room_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["room_id", "user_id"], name: "index_entries_on_room_id_and_user_id", unique: true
      t.index ["room_id"], name: "index_entries_on_room_id"
      t.index ["user_id"], name: "index_entries_on_user_id"
    end
    create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.bigint "article_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["article_id"], name: "fk_rails_86adad7015"
      t.index ["user_id", "article_id"], name: "index_likes_on_user_id_and_article_id", unique: true
    end
    create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "article_id", null: false
      t.string "address"
      t.float "latitude"
      t.float "longitude"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["article_id"], name: "index_maps_on_article_id"
    end
    create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.bigint "room_id", null: false
      t.text "content"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["room_id"], name: "index_messages_on_room_id"
      t.index ["user_id"], name: "index_messages_on_user_id"
    end
    create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.integer "visiter_id"
      t.integer "visited_id"
      t.bigint "article_id"
      t.bigint "comment_id"
      t.bigint "message_id"
      t.string "action"
      t.boolean "checked", default: false, null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["article_id"], name: "index_notifications_on_article_id"
      t.index ["comment_id"], name: "index_notifications_on_comment_id"
      t.index ["message_id"], name: "index_notifications_on_message_id"
    end
    create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.text "content"
      t.string "address"
      t.integer "age"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "favorite"
      t.index ["user_id"], name: "index_profiles_on_user_id"
    end
    create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.integer "follower_id", null: false
      t.integer "followed_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true
      t.index ["followed_id"], name: "index_relationships_on_followed_id"
      t.index ["follower_id"], name: "index_relationships_on_follower_id"
    end
    create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.integer "reviewer_id"
      t.integer "reviewed_id"
      t.text "content"
      t.integer "rate"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["reviewed_id"], name: "index_reviews_on_reviewed_id"
      t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
    end
    create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "name"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
    create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.integer "tag_id"
      t.string "taggable_type"
      t.integer "taggable_id"
      t.string "tagger_type"
      t.integer "tagger_id"
      t.string "context", limit: 128
      t.datetime "created_at"
      t.index ["context"], name: "index_taggings_on_context"
      t.index ["tag_id"], name: "index_taggings_on_tag_id"
      t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
      t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
      t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
      t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
      t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
      t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    end
    create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "name", collation: "utf8_bin"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer "taggings_count", default: 0
    end
    create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
      t.string "name"
      t.string "email"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "password_digest"
      t.string "remember_digest"
      t.boolean "admin"
      t.string "token"
      t.float "ave_rate"
      t.string "avatar"
      t.integer "review_count"
      t.boolean "coach", default: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "articles", "users"
    add_foreign_key "comments", "articles"
    add_foreign_key "comments", "users"
    add_foreign_key "entries", "rooms"
    add_foreign_key "entries", "users"
    add_foreign_key "likes", "articles"
    add_foreign_key "likes", "users"
    add_foreign_key "maps", "articles"
    add_foreign_key "messages", "rooms"
    add_foreign_key "messages", "users"
    add_foreign_key "profiles", "users"
    add_foreign_key "taggings", "tags"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
