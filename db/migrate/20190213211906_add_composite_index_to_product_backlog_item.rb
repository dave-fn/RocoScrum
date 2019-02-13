class AddCompositeIndexToProductBacklogItem < ActiveRecord::Migration[5.2]
  def change
    add_index :product_backlog_items, [:product_id, :backlog_item_id], unique: true
    add_index :product_backlog_items, [:backlog_item_id, :product_id], unique: true
  end
end
