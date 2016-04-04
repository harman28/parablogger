class CreatePostsParagraphs < ActiveRecord::Migration
  def change
    create_table :posts_paragraphs do |t|
      t.text :body
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
