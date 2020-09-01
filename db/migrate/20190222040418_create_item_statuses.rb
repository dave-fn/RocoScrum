class CreateItemStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :item_statuses do |t|
      t.references :team, foreign_key: true
      t.string :context, limit: 5, null: false
      t.string :title, null: false
      t.string :description

      t.index [:team_id, :context, :title], unique: true

      t.timestamps
    end
    add_index :item_statuses, :context
  end
end
