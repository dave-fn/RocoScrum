class CreateSprintBacklogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sprint_backlog_items do |t|
      t.references :sprint, foreign_key: true
      t.references :backlog_item, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
