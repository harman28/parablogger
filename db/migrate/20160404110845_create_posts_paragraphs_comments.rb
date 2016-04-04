class CreatePostsParagraphsComments < ActiveRecord::Migration
  def change
    create_table :posts_paragraphs_comments do |t|
      t.text :body
      t.references :posts_paragraph, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
