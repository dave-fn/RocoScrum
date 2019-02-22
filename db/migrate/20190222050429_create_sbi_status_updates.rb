class CreateSbiStatusUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :sbi_status_updates do |t|
      t.references :sprint_backlog_item, foreign_key: true
      t.references :item_status, foreign_key: true
      t.references :developer, foreign_key: true
      t.references :creator, foreign_key: true

      t.timestamps
    end
  end
end
