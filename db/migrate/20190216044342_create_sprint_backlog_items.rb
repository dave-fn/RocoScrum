class CreateSprintBacklogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sprint_backlog_items do |t|
      t.references :sprint, foreign_key: true
      t.references :backlog_item, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :position

      t.index [:sprint_id, :backlog_item_id], unique: true
      t.index [:backlog_item_id, :sprint_id], unique: true

      t.timestamps
    end
  end
end
