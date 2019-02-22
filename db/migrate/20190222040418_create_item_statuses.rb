class CreateItemStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :item_statuses do |t|
      t.references :team, foreign_key: true
      t.string :context
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :item_statuses, :context
  end
end
