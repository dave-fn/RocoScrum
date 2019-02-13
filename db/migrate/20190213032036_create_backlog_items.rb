class CreateBacklogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :backlog_items do |t|
      t.string :title, null: false
      t.text :requirement
      t.text :description
      t.boolean :ready, default: false

      t.timestamps
    end
  end
end
