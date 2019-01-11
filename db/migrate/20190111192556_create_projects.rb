class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.references :admin, foreign_key: {to_table: :users}, index: true

      t.timestamps
    end
  end
end
