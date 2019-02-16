class CreateProjectSprints < ActiveRecord::Migration[5.2]
  def change
    create_table :project_sprints do |t|
      t.references :project, foreign_key: true
      t.references :sprint, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
