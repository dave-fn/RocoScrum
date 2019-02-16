class CreateProjectSprints < ActiveRecord::Migration[5.2]
  def change
    create_table :project_sprints do |t|
      t.references :project, foreign_key: true
      t.references :sprint, foreign_key: true
      t.integer :position

      t.index [:project_id, :sprint_id], unique: true
      t.index [:sprint_id, :project_id], unique: true

      t.timestamps
    end
  end
end
