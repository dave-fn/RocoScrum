class CreateProductBacklogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :product_backlog_items do |t|
      t.references :product, foreign_key: true
      t.references :backlog_item, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
