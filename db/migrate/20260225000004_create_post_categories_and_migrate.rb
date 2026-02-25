class CreatePostCategoriesAndMigrate < ActiveRecord::Migration[8.1]
  def up
    create_table :post_categories do |t|
      t.references :post, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_categories, [ :post_id, :category_id ], unique: true

    # 既存の category_id を post_categories に移行
    say_with_time "Migrating existing post categories" do
      execute(<<~SQL.squish)
        INSERT INTO post_categories (post_id, category_id, created_at, updated_at)
        SELECT id, category_id, datetime('now'), datetime('now')
        FROM posts WHERE category_id IS NOT NULL
      SQL
    end

    remove_foreign_key :posts, :categories
    remove_column :posts, :category_id
  end

  def down
    add_reference :posts, :category, foreign_key: true

    execute(<<~SQL.squish)
      UPDATE posts SET category_id = (
        SELECT category_id FROM post_categories
        WHERE post_categories.post_id = posts.id
        LIMIT 1
      )
    SQL

    drop_table :post_categories
  end
end
