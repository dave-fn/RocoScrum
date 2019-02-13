class CreateSprints < ActiveRecord::Migration[5.2]
  def change
    create_table :sprints do |t|
      t.string :title, null: false
      t.text :description
      t.text :goal
      t.integer :duration
      t.datetime :started_at

      t.timestamps
    end
  end
end
