class AddOrderIdToPostsParagraphs < ActiveRecord::Migration
  def change
    add_column :posts_paragraphs, :order_id, :integer, null: false
  end
end
